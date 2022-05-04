import 'dart:convert';

import 'package:firedart/auth/exceptions.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enuyoung_crawller_flutter/MySetting.dart';
import 'package:enuyoung_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/FirebaseAuthUtilInterface.dart';
import 'package:enuyoung_crawller_flutter/firebase_options.dart';

class FiredartAuthSingleton extends FirebaseAuthUtilInterface {
  static final FiredartAuthSingleton _singleton =
      FiredartAuthSingleton._internal();
  static FiredartAuthSingleton get me=>_singleton;

  FiredartAuthSingleton._internal();

  FirebaseAuth get _instance => FirebaseAuth.instance;

  @override
  Future<void> init() async {
    if (!haveEverInit) {
      haveEverInit = true;

      FirebaseAuth.initialize(
          DefaultFirebaseOptions.web.apiKey, await HiveStore.create());
      // _instance.signInState.listen((state) {
      //   LogUtil.debug("Signed ${state ? "in" : "out"}");
      // });
    }
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    User? user = await getUser();
    if (user == null) {
      LogUtil.error("user is null");
      return;
    }

    await _instance.updateProfile(
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  @override
  Future<User?> getUser() async {
    try {
      var user = await _instance.getUser();
      LogUtil.debug("user : $user");
      return user;
    } on SignedOutException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> loginAnonymously() async {
    try {
      await _instance.signInAnonymously();
      return await getUser();
    } on AuthException catch (e) {
      var code = e.message;
      throw CommonException(code: code);
    }
  }

  @override
  Future<User?> registerWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.signUp(email, password);
      return await getUser();
    } on AuthException catch (e) {
      var code = e.message;
      if (code == 'EMAIL_EXISTS') {
        throw CommonException(
            message: "이미 ID가 있습니다", code: "email-already-in-use");
      } else if (code == 'TOO_MANY_ATTEMPTS_TRY_LATER') {
        throw CommonException(
            message: "잠시 후에 다시 시도해주세요", code: "too-many-requests");
      } else {
        throw CommonException(code: code);
      }
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    User? user = await getUser();
    if (user == null) {
      LogUtil.error("user is null");
      return;
    }

    try {
      await _instance.requestEmailVerification(
          langCode: MySetting.defaultLocale.languageCode);
    } on AuthException catch (e) {
      var code = e.message;
      if (code == 'EMAIL_EXISTS') {
        throw CommonException(
            message: "이미 ID가 있습니다", code: "email-already-in-use");
      } else {
        LogUtil.error("FireauthUtil.sendEmailVerification ${code}");
      }
    }
  }

  @override
  Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.signIn(email, password);
      return await getUser();
    } on AuthException catch (e) {
      var code = e.message;
      if (code == 'EMAIL_NOT_FOUND') {
        return null;
      } else if (code == 'INVALID_PASSWORD') {
        throw CommonException(message: "비밀번호가 틀렸습니다", code: "wrong-password");
      } else {
        throw CommonException(code: code);
      }
    }
  }

  @override
  Future<void> logout() async {
    _instance.signOut();
  }

  @override
  Future<void> delete() async {
    try {
      User? user = await getUser();
      if (user != null) {
        await _instance.deleteAccount();
      }
    } catch (e) {
      LogUtil.error("FireauthUtil.delete error $e");
    }
  }
}

const keyToken = "auth_token";

class PreferencesStore extends TokenStore {
  static Future<PreferencesStore> create() async =>
      PreferencesStore._internal(await SharedPreferences.getInstance());

  final SharedPreferences _prefs;

  PreferencesStore._internal(this._prefs);

  @override
  Token? read() => _prefs.containsKey(keyToken)
      ? Token.fromMap(json.decode(_prefs.getString(keyToken)!))
      : null;

  @override
  void write(Token? token) => token != null
      ? _prefs.setString(keyToken, json.encode(token.toMap()))
      : null;

  @override
  void delete() => _prefs.remove(keyToken);
}

class HiveStore extends TokenStore {
  static Future<HiveStore> create() async {
    var box = await Hive.openBox("auth_store",
        compactionStrategy: (entries, deletedEntries) => deletedEntries > 50);
    return HiveStore._internal(box);
  }

  final Box _box;

  HiveStore._internal(this._box);

  @override
  Token? read() => _box.get(keyToken);

  @override
  void write(Token? token) => token != null ? _box.put(keyToken, token) : null;

  @override
  void delete() => _box.delete(keyToken);
}

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final typeId = 42;

  @override
  void write(BinaryWriter writer, Token obj) => writer.writeMap(obj.toMap());

  @override
  Token read(BinaryReader reader) =>
      Token.fromMap(reader.readMap().map<String, dynamic>(
          (key, value) => MapEntry<String, dynamic>(key, value)));
}
