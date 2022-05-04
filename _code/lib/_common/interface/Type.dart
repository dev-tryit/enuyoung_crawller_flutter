
import 'package:flutter/material.dart';

typedef ConsumerBuilderType<T> = Widget Function(
  BuildContext context,
  T service,
  Widget? child,
);
