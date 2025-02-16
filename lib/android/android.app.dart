import 'package:contact_app/android/app.router.dart';
import 'package:contact_app/android/core/services/post.serivce.dart';
import 'package:contact_app/android/view/home.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/styles.dart';
import 'core/services/contact.service.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContactService>(create: (_) => ContactService()),
        Provider<PostService>(create: (_) => PostService()),
      ],
      child: MaterialApp.router(
        title: 'Contact App',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: androidTheme(),
      ),
    );
  }
}
