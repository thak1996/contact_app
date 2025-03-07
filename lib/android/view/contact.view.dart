import 'package:contact_app/android/controller/contact.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/contact.model.dart';
import 'widgets/alert_dialog.widget.dart';
import 'widgets/app_bar.widget.dart';
import 'widgets/contact.listtile.dart';
import 'widgets/drawer.widget.dart';
import 'widgets/edit_contact_dialog.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactController()..fetchContacts(),
      child: Scaffold(
        appBar: AppBarWidget(title: 'Contact Page', showAddButton: true),
        drawer: DrawerWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<ContactController, ContactState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case const (ContactUpdated):
                    final contactUpdatedState = state as ContactUpdated;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(contactUpdatedState.message)),
                    );
                    break;
                  case const (ContactDeleted):
                    final contactDeletedState = state as ContactDeleted;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(contactDeletedState.message)),
                    );
                    break;
                  case const (ContactDeleteError):
                    final deleteErrorState = state as ContactDeleteError;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialogWidget(
                        mesage: deleteErrorState.message,
                      ),
                    );
                    break;
                }
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (ContactLoading):
                    return Center(child: CircularProgressIndicator());
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
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeLoadedState.contacts.length,
                            itemBuilder: (context, index) {
                              final contact = homeLoadedState.contacts[index];
                              return ContactListTile(
                                contact: contact,
                                onDelete: () => context //
                                    .read<ContactController>()
                                    .deleteContact(contact),
                                onEdit: () => _showEditDialog(context, contact),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  case const (ContactError):
                    final homeErrorState = state as ContactError;
                    return Center(
                      child: Text('Erro: ${homeErrorState.message}'),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Contact contact) {
    final contectController = context.read<ContactController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditContactDialog(
          contact: contact,
          contactController: contectController,
        );
      },
    );
  }
}
