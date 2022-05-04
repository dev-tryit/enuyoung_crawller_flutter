import 'package:firedart/firedart.dart';
import 'package:enuyoung_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:enuyoung_crawller_flutter/_common/util/UUIDUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';
import 'package:enuyoung_crawller_flutter/firebase_options.dart';

class FiredartStoreUtil<Type extends WithDocId>
    extends FirebaseStoreUtilInterface<Type> {
  FiredartStoreUtil(
      {required String collectionName,
      required Type Function(Map<String, dynamic> map) fromMap,
      required Map<String, dynamic> Function(Type instance) toMap})
      : super(collectionName: collectionName, fromMap: fromMap, toMap: toMap) {
    try{
      Firestore.initialize(DefaultFirebaseOptions.web.projectId);
    }
    catch(pass){}
  }

  @override
  CollectionReference cRef() {
    return Firestore.instance.collection(collectionName);
  }

  @override
  DocumentReference dRef({int? documentId}) {
    return documentId != null
        ? cRef().document(documentId.toString())
        : cRef().document(UUIDUtil().makeUuid());
  }

  @override
  Future<Map<String, dynamic>> dRefToMap(dRef) async => (await dRef.get()).map;

  @override
  Map<String, dynamic> dSnapshotToMap(dSnapshot) => dSnapshot.map;

  @override
  Future<List> cRefToList() async => (await cRef().get());

  @override
  Future<List> queryToList(query) async => (await query.get());
}
