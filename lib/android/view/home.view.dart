import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controller/home.controller.dart';
import 'widgets/app_bar.widget.dart';
import 'widgets/home.listtile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeController(),
      child: Scaffold(
        appBar: AppBarWidget(title: 'Home Page'),
        body: Center(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                HomeListTile(
                  leading: Icons.contact_page_outlined,
                  title: 'Contatos',
                  onTap: () => context.push('/contact'),
                ),
                const SizedBox(height: 10),
                HomeListTile(
                  leading: Icons.post_add_outlined,
                  title: 'Posts',
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
