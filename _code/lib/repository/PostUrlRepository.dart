import 'package:enuyoung_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class PostUrl extends WithDocId {
  static const String staticClassName = "PostUrl";
  final className = staticClassName;
  String? instaUserId;
  String? url;
  List? mediaUrlList;

  PostUrl(
      {required this.instaUserId, required this.url, required this.mediaUrlList})
      : super(documentId: DateTime.now().microsecondsSinceEpoch);

  factory PostUrl.fromJson(Map<String, dynamic> json) => fromMap(json);

  Map<String, dynamic> toJson() => toMap(this);

  static PostUrl fromMap(Map<String, dynamic> map) {
    return PostUrl(
      instaUserId: map['instaUserId'],
      url: map['url'],
      mediaUrlList: map['mediaUrlList'],
    )
      ..documentId = map['documentId']
      ..email = map['email'];
  }

  static Map<String, dynamic> toMap(PostUrl instance) {
    return {
      'documentId': instance.documentId,
      'email': instance.email,
      'instaUserId': instance.instaUserId,
      'url': instance.url,
      'mediaUrlList': instance.mediaUrlList,
    };
  }
}

class PostUrlRepository {
  static final PostUrlRepository _singleton = PostUrlRepository._internal();
  static PostUrlRepository get me=>_singleton;

  PostUrlRepository._internal();

  final FirebaseStoreUtilInterface<PostUrl> _ =
      FirebaseStoreUtilInterface.init<PostUrl>(
    collectionName: PostUrl.staticClassName,
    fromMap: PostUrl.fromMap,
    toMap: PostUrl.toMap,
  );

  Future<PostUrl?> save({required PostUrl postUrl}) async {
    return await _.saveByDocumentId(instance: postUrl);
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

  Future<PostUrl?> getOne() async {
    return await _.getOneByField(onlyMyData: true);
  }

  Future<PostUrl?> getOneByUrl(String url) async {
    return await _.getOneByField(onlyMyData: true, key: "url", value:url);
  }

  Future<List<PostUrl>> getList() async {
    return await _.getList(onlyMyData: true);
  }
}
