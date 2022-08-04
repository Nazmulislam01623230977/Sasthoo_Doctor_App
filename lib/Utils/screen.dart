import 'package:flutter/material.dart';

class Utils {
  Size getScreen() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }
}
