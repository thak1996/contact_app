import 'package:contact_app/android/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'constants/styles.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      debugShowCheckedModeBanner: false,
      theme: androidTheme(),
      home: HomePage(),
    );
  }
}
