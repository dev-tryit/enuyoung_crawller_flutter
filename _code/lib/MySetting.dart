import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MySetting {
  static const bool isRelease = false;

  //Lang
  static const Locale defaultLocale = Locale('ko', 'kr');

  // DateTime
  static const int timeZoneOffset = 9;

  // App
  static const String appName = "Insta Manager";

  // 중복 클릭 방지 시간
  static int milliSecondsForPreventingMultipleClicks = 300;

  static PageTransition defaultPageTransition(Widget nextPage) => PageTransition(
    type: PageTransitionType.fade,
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 300),
    child: nextPage,
  );

// static String appVersion = "";
//
// static String appBuildNumber = "";
}
