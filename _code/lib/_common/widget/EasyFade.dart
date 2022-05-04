import 'dart:async';

import 'package:flutter/material.dart';

class EasyFade extends StatefulWidget {
  final Widget child;
  final int afterAFewMilliseconds;
  final int timeToBeShown;

  const EasyFade(
      {Key? key,
      required this.child,
      this.afterAFewMilliseconds = 500,
      this.timeToBeShown = 800})
      : super(key: key);

  @override
  _EasyFadeState createState() => _EasyFadeState();
}

class _EasyFadeState extends State<EasyFade> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    if (opacity == 0) {
      Timer(Duration(milliseconds: widget.afterAFewMilliseconds), () {
        opacity = 1;
        setState(() {});
      });
    }
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: widget.timeToBeShown),
      child: widget.child,
    );
  }
}
