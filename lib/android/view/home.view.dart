import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/home.controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
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
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return CircularProgressIndicator();
                  } else if (state is HomeLoaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.contacts.length,
                          itemBuilder: (context, index) {
                            final contact = state.contacts[index];
                            return ListTile(
                              leading: CircleAvatar(child: Icon(Icons.person)),
                              title: Text(
                                contact.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                contact.email,
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is HomeError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Erro: ${state.message}'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Clique no botão para carregar os contatos'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
