import 'package:contact_app/android/view/home.view.dart';
import 'package:flutter/material.dart';
import 'core/constants/styles.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      debugShowCheckedModeBanner: false,
      theme: androidTheme(),
      home: HomeView(),
    );
  }
}
