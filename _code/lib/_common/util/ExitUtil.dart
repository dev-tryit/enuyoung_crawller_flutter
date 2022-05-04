import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitUtil {
  static Future<void> exit(BuildContext context, {Widget? exitedPage}) async {
    if (kIsWeb) {
      // window.close();//웹 종료. 크롬은 탭을 종료시키는게 불가능하다.

      //대응코드1
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => exitedPage ?? ExitedPageForWep(),
        ),
        (Route<dynamic> route) => route.isFirst,
      );

      //대응코드2
      //Web은 exit가 안되서, 맨 첫화면으로 이동시키는 코드를 만들었따.
      // var uri = Uri.parse(window.location.href);
      // window.location.href = "${uri.scheme}://${uri.host}:${uri.port}";
    } else {
      // exit(0); //비정상 종료이므로 왠만하면 쓰지말자
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}

class ExitedPageForWep extends StatefulWidget {
  const ExitedPageForWep({Key? key}) : super(key: key);

  @override
  _ExitedPageForWepState createState() => _ExitedPageForWepState();
}

class _ExitedPageForWepState extends State<ExitedPageForWep> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("종료되었습니다"),
        ),
      ),
    );
  }
}
