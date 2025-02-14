import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/home.controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Meus Contatos'),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.search),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().fetchContacts();
                      log("Carregando contatos...");
                    },
                    child: Text('Carregar Contatos'),
                  ),
                  SizedBox(
                      height: 20), // Adiciona um espaço entre o botão e o texto
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return CircularProgressIndicator();
                      } else if (state is HomeLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Contatos: ${state.contacts.toString()}'),
                        );
                      } else if (state is HomeError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Erro: ${state.message}'),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text('Clique no botão para carregar os contatos'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
