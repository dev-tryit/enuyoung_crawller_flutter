import 'package:enuyoung_crawller_flutter/_common/util/hive/HiveUtil.dart';

class MyStoreUtil {
  /*
    로컬 저장소 : HiveUtil 사용
    원격 저장소 : Firestore 사용 (컴퓨터:firedart 라이브러리, 나머지:firebase 정식라이브러리)
   */
  static Future<void> init() async {
    await HiveUtil.init();
  }

}