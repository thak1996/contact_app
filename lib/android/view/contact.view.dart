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
                switch (state) {
                  case ContactLoading():
                    Center(child: CircularProgressIndicator());
                  case ContactUpdated():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    break;
                  case ContactDeleted():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    break;
                  case ContactDeleteError():
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialogWidget(
                        mesage: state.message,
                      ),
                    );
                    break;
                  default:
                    break;
                }
              },
              builder: (context, state) {
                switch (state) {
                  case ContactLoading():
                    return Center(child: CircularProgressIndicator());
                  case ContactLoaded():
                    return Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async => await context //
                              .read<ContactController>()
                              .fetchContacts(),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.contacts.length,
                            itemBuilder: (context, index) {
                              final contact = state.contacts[index];
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
                  case ContactError():
                    return Center(child: Text('Erro: ${state.message}'));
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
      builder: (BuildContext context) => EditContactDialog(
        contact: contact,
        contactController: contectController,
      ),
    );
  }
}
