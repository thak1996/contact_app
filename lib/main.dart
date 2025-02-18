import 'package:contact_app/android/android.app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

// void main() {
//   if (Platform.isAndroid) {
//     runApp(const AndroidApp());
//   } else {}
// }

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const AndroidApp());
}
