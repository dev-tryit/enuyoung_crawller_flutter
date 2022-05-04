import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enuyoung_crawller_flutter/_common/abstract/WithDocId.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/FirebaseStoreUtilInterface.dart';

class FirebaseStoreUtil<Type extends WithDocId>
    extends FirebaseStoreUtilInterface<Type> {
  FirebaseStoreUtil(
      {required String collectionName,
      required Type Function(Map<String, dynamic> map) fromMap,
      required Map<String, dynamic> Function(Type instance) toMap})
      : super(collectionName: collectionName, fromMap: fromMap, toMap: toMap) {
    // FirebaseFirestore.instance.
  }

  @override
  CollectionReference cRef() =>
      FirebaseFirestore.instance.collection(collectionName);

  @override
  DocumentReference dRef({int? documentId}) =>
      documentId != null ? cRef().doc(documentId.toString()) : cRef().doc();

  @override
  Future<Map<String, dynamic>> dRefToMap(dRef) async =>
      ((await dRef.get()).data() as Map<String, dynamic>?) ?? {};

  @override
  Map<String, dynamic> dSnapshotToMap(dSnapshot) =>
      (dSnapshot.data() as Map<String, dynamic>?) ?? {};
  @override
  Future<List> cRefToList() async => (await cRef().get()).docs;
  @override
  Future<List> queryToList(query) async => (await query.get()).docs;
}
