import 'dart:async';

import 'package:enuyoung_crawller_flutter/page/TestPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/MySetting.dart';
import 'package:enuyoung_crawller_flutter/_common/config/MyCustomScrollBehavior.dart';
import 'package:enuyoung_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/DesktopUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/ErrorUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:enuyoung_crawller_flutter/page/SplashPage.dart';
import 'package:enuyoung_crawller_flutter/service/CrawllerService.dart';
import 'package:enuyoung_crawller_flutter/service/PostUrlService.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';
import 'package:enuyoung_crawller_flutter/util/MyFonts.dart';
import 'package:enuyoung_crawller_flutter/util/MyStoreUtil.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

const width = 350.0;
const height = 700.0;

Future<void> main() async {
  ErrorUtil.catchError(() async {
    if (!PlatformUtil.isComputer()) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    await MyFonts.init();
    await MyStoreUtil.init();
    await AuthUtil.me.init();

    if (PlatformUtil.isComputer()) {
      DesktopUtil.setDesktopSetting(
          size: const Size(width, height),
          minimumSize: const Size(width, height),
          maximumSize: const Size(width, height),
          title: MySetting.appName);
    }
    runApp(MultiProvider(
      providers: [
        PostUrlService.provider,
        CrawllerService.provider,
      ],
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MySetting.appName,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.white,
        // primaryColor: Colors.lightBlue[800],
        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: const TextTheme(d
        //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
      builder: (context, child) {
        // 1. FittedBox는 부모와 크기가 같게 만드는 성질이 있다.
        // 2. FittedBox + SizedBox를 사용하면,
        // Sizedbox를 통해 비율이 결정되고,
        // FittedBox를 통해 크기를 부모에 맞추려고 하여, 축적(확대,축소)가 변경된다.
        child = FittedBox(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: child!,
          ),
        );
        child = MyComponents.easyLoadingBuilder()(context, child);
        return child;
      },
      home: TestPage(),
    );
  }
}
