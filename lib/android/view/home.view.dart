import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controller/home.controller.dart';
import 'widgets/home.listtile.dart';

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
          title: const Text('Home Page'),
          centerTitle: true,
        ),
        body: Center(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                HomeListTile(
                  leading: const Icon(Icons.contact_page_outlined),
                  title: const Text('Contatos'),
                  onTap: () => context.push('/contact'),
                ),
                const SizedBox(height: 10),
                HomeListTile(
                  leading: const Icon(Icons.post_add_outlined),
                  title: const Text('Posts'),
                  onTap: () => context.push('/post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
