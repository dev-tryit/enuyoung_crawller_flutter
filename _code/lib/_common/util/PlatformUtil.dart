import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

enum os { Unknown, Web, Android, Fuchsia, IOS, Linux, MacOS, Windows }

class PlatformUtil {
  static os getPlatform() {
    if (kIsWeb) {
      return os.Web;
    } else if (Platform.isIOS) {
      return os.IOS;
    } else if (Platform.isAndroid) {
      return os.Android;
    } else if (Platform.isFuchsia) {
      return os.Fuchsia;
    } else if (Platform.isLinux) {
      return os.Linux;
    } else if (Platform.isMacOS) {
      return os.MacOS;
    } else if (Platform.isWindows) {
      return os.Windows;
    }
    return os.Unknown;
  }

  static bool isWeb() {
    os platform = getPlatform();
    bool b = (platform == os.Web);

    // LogUtil.debug("isWeb");
    return b;
  }

  static bool isMobile() {
    os platform = getPlatform();
    bool b =  (platform == os.Android ||
        platform == os.IOS ||
        platform == os.Fuchsia);

    // LogUtil.debug("isMobile");
    return b;
  }

  static bool isComputer() {
    os platform = getPlatform();
    bool b =  (platform == os.Linux ||
        platform == os.MacOS ||
        platform == os.Windows);

    // LogUtil.debug("isComputer");
    return b;
  }
}
