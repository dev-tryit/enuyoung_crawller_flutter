
import 'package:hive_flutter/hive_flutter.dart';
import 'package:enuyoung_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/firebase/firedart/FiredartAuthSingleton.dart';

class HiveUtil {
  static Future<void> init() async {
    Hive.initFlutter();
    if(PlatformUtil.isComputer()) {
      Hive.registerAdapter(TokenAdapter());
    }
  }
}
