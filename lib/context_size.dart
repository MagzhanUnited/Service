import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContextSize {
  static late double _absoluteHeight;
  static late double _absoluteWidth;
  static void init(BuildContext context) {
    _absoluteHeight = context.mediaQuerySize.height;
  }
  
}
