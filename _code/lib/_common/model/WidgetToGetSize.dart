import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/SizeUtil.dart';

class WidgetToGetSize<T> {
  dynamic key;
  late Widget Function() make;
  final _globalKey = GlobalKey();
  late Size size;
  late double w;
  late double h;

  WidgetToGetSize(this.key, Widget Function(GlobalKey key) makeWidget) {
    this.make = () {
      return makeWidget(_globalKey);
    };
  }

  void calculateSize() {
    size = SizeUtil.getSizeByKey(_globalKey);
    w = size.width;
    h = size.height;
    LogUtil.debug("[$key] size: $size");
  }
}
