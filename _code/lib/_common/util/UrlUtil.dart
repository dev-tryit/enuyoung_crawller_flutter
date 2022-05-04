
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      LogUtil.warn('Could not launch $url');
    }
  }
}