import 'dart:io';

import 'package:contact_app/android/android.app.dart';
import 'package:flutter/material.dart';

void main() {
  if (Platform.isAndroid) {
    runApp(const AndroidApp());
  } else {}
}
