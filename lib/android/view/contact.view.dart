import 'package:contact_app/android/controller/contact.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/app_bar.widget.dart';
import 'widgets/contact.listtile.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactController()..fetchContacts(),
      child: Scaffold(
        appBar: AppBarWidget(title: 'Contact Page'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ContactController, ContactState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (ContactLoading):
                    return CircularProgressIndicator();
                  case const (ContactLoaded):
                    final homeLoadedState = state as ContactLoaded;
                    return Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await context //
                                .read<ContactController>()
                                .fetchContacts();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeLoadedState.contacts.length,
                            itemBuilder: (context, index) {
                              final contact = homeLoadedState.contacts[index];
                              return ContactListTile(contact: contact);
                            },
                          ),
                        ),
                      ),
                    );
                  case const (ContactError):
                    final homeErrorState = state as ContactError;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Erro: ${homeErrorState.message}'),
                    );
                  default:
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
    );
  }
}
