import 'package:firebase_auth/firebase_auth.dart';
import 'package:enuyoung_crawller_flutter/MySetting.dart';
import 'package:enuyoung_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/FirebaseAuthUtilInterface.dart';

class FirebaseAuthSingleton extends FirebaseAuthUtilInterface {
  static final FirebaseAuthSingleton _singleton =
      FirebaseAuthSingleton._internal();
  static FirebaseAuthSingleton get me=>_singleton;

  FirebaseAuthSingleton._internal();

  FirebaseAuth get _instance => FirebaseAuth.instance;

  @override
  Future<void> init() async {
    if (!haveEverInit) {
      haveEverInit = true;

      //이외 플랫폼(firebase_auth, 정식)

      await _instance.setLanguageCode(
          MySetting.defaultLocale.languageCode); //이메일 보낼 때 한국어로 보냄

      //setPersistence를 통해서, 웹의 경우, 로그인 유지를 시킬지, 세션에만 시킬지, 안시킬지 결정할 수 있다.

      //IOS는 앱을 재설치하면, 로그인 정보가 남아 있을 수 있다. IOS는 키체인에 데이터를 저장하는데, 키체인이 앱삭제시 유지되기도 함.

      //authStateChanges는 회원가입, 로그인, 로그아웃까지.
      //idTokenChanges는 authStateChanges + 토큰 변경까지. (ADMIN SDK에 의한것은 감지 X)
      //userChanges는 idTokenChanges는 + currentUser의 내용이 변경되는 함수가 호출될 때 (ADMIN SDK에 의한것은 감지 X)
      //이 부분에서 이메일 인증을 체크할 수 없다.
      // _instance.idTokenChanges().listen((User? user) {
      //   //변경사항 체크하는 곳이다. 절대, user를 주는곳이 아니라는 것을 알아야 한다.
      // });
    }
  }

  @override
  Future<User?> getUser() async {
    if (!haveEverGetUser) {
      haveEverGetUser = true;
      await for (var user in _instance.idTokenChanges()) {
        return user;
      }
    }

    return _instance.currentUser; //빠르게 얻기
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    User? user = await getUser();
    if (user == null) {
      LogUtil.error("user is null");
      return;
    }

    if (displayName != null) {
      await user.updateDisplayName(displayName);
    }

    if (photoUrl != null) {
      await user.updatePhotoURL(photoUrl);
    }
  }

  @override
  Future<User?> loginAnonymously() async {
    try {
      await _instance.signInAnonymously();
      return getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CommonException(message: "비밀번호 형식이 안전하지 않습니다", code: e.code);
      } else if (e.code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: e.code);
      } else if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: e.code);
      } else if (e.code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: e.code);
      } else if (e.code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: e.code);
      } else {
        throw CommonException(code: e.code);
      }
    }
  }

  @override
  Future<User?> registerWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CommonException(message: "비밀번호 형식이 안전하지 않습니다", code: e.code);
      } else if (e.code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: e.code);
      } else if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: e.code);
      } else if (e.code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: e.code);
      } else if (e.code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: e.code);
      } else {
        throw CommonException(code: e.code);
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
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: e.code);
      } else {
        LogUtil.error("FireauthUtil.sendEmailVerification ${e.code}");
      }
    }
  }

  @override
  Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      return getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      } else if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'wrong-password') {
        throw CommonException(message: "비밀번호가 틀렸습니다", code: e.code);
      } else if (e.code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: e.code);
      } else if (e.code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: e.code);
      } else if (e.code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: e.code);
      } else {
        throw CommonException(code: e.code);
      }
    }
  }

  @override
  Future<void> logout() async {
    await _instance.signOut();
  }

  @override
  Future<void> delete() async {
    try {
      User? user = await getUser();
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      LogUtil.error("FireauthUtil.delete error $e");
    }
  }
}
