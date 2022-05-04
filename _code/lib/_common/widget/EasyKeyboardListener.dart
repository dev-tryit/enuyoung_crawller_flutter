import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';

class EasyKeyboardListener extends StatelessWidget {
  final focusNode = FocusNode();
  final ValueChanged<String> onValue;
  final Widget child;
  final int inputLimit;
  String input = "";

  EasyKeyboardListener(
      {Key? key,
      required this.child,
      required this.inputLimit,
      required this.onValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode); // Add this line
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (keyEvent) {
        if (keyEvent is KeyDownEvent) {
          input += keyEvent.character ?? "";
          if (input.length >= (inputLimit + 1)) {
            input = input.substring(1);
          }

          onValue(input);
        }
      },
      child: child,
    );
  }
}
