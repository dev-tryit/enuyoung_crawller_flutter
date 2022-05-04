import 'package:enuyoung_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class InstaUser extends WithDocId {
  static const String staticClassName = "InstaUser";
  final className = staticClassName;
  String? id;
  String? pw;

  InstaUser(
      {required this.id, required this.pw})
      : super(documentId: DateTime.now().microsecondsSinceEpoch);

  factory InstaUser.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static InstaUser fromMap(Map<String, dynamic> map) {
    return InstaUser(
      id: map['id'],
      pw: map['pw'],
    )
      ..documentId = map['documentId']
      ..email = map['email'];
  }

  static Map<String, dynamic> toMap(InstaUser instance) {
    return {
      'documentId': instance.documentId,
      'email': instance.email,
      'id': instance.id,
      'pw': instance.pw,
    };
  }
}

class InstaUserRepository {
  static final InstaUserRepository _singleton = InstaUserRepository._internal();
  static InstaUserRepository get me=>_singleton;

  InstaUserRepository._internal();

  final FirebaseStoreUtilInterface<InstaUser> _ =
      FirebaseStoreUtilInterface.init<InstaUser>(
    collectionName: InstaUser.staticClassName,
    fromMap: InstaUser.fromMap,
    toMap: InstaUser.toMap,
  );

  Future<InstaUser?> save({required InstaUser instaUser}) async {
    return await _.saveByDocumentId(instance: instaUser);
  }

  Future<bool> existDocumentId({required String documentId}) async {
    return await _.exist(
      key: "documentId",
      value: documentId,
    );
  }

  Future<void> delete({required int documentId}) async {
    await _.deleteOne(documentId: documentId);
  }

  Future<InstaUser?> getOne() async {
    return await _.getOneByField(onlyMyData: true);
  }

  Future<List<InstaUser>> getList() async {
    return await _.getList(onlyMyData: true);
  }
}
