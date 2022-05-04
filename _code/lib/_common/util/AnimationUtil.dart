import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/src/slidable.dart';

class AnimationUtil {
  static Widget bounceInDown(
      {required Widget child,
      Duration duration = const Duration(milliseconds: 100)}) {
    return BounceInUp(
      child: child,
    );
  }

  static Widget fadeOutLeft(
      {required Widget child,
      Duration duration = const Duration(milliseconds: 100),
      required VoidCallback onPressed}) {
    return FadeOutLeft(
      duration: duration,
      child: child,
    );
  }

  static Widget slideInLeft(
      {required Widget child,
      Duration duration = const Duration(milliseconds: 600),
      Duration delay = const Duration(milliseconds: 0),
      Function(AnimationController)? controller,
      bool manualTrigger = false,
      bool animate = true,
      double from = 100}) {
    return SlideInLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from);
  }
}

  /*
@FadeIn Animations
FadeIn
FadeInDown
FadeInDownBig
FadeInUp
FadeInUpBig
FadeInLeft
FadeInLeftBig
FadeInRight
FadeInRightBig

@FadeOut Animations
FadeOut
FadeOutDown
FadeOutDownBig
FadeOutUp
FadeOutUpBig
FadeOutLeft
FadeOutLeftBig
FadeOutRight
FadeOutRightBig

@BounceIn Animations
BounceInDown
BounceInUp
BounceInLeft
BounceInRight

@ElasticIn Animations
ElasticIn
ElasticInDown
ElasticInUp
ElasticInLeft
ElasticInRight

@SlideIns Animations
SlideInDown
SlideInUp
SlideInLeft
SlideInRight

@FlipIn Animations
FlipInX
FlipInY
Zooms
ZoomIn
ZoomOut

@SpecialIn Animations
JelloIn
Attention Seeker
Bounce
Flash
Pulse
Swing
Spin
SpinPerfect
Dance
Roulette

*/