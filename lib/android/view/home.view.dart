import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/home.controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Home Page'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.search),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ),
        body: Column(),
      ),
    );
  }
}
