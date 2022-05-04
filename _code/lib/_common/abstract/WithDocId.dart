import 'package:enuyoung_crawller_flutter/_common/util/AuthUtil.dart';

abstract class WithDocId {
  int? documentId;
  String? email;

  WithDocId({this.documentId}) {
    email = AuthUtil.me.email;
  }

  @override
  bool operator ==(dynamic other) => documentId == other.documentId;
}
