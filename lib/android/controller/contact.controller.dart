import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/services/contact.service.dart';
import '../models/contact.model.dart';

class ContactController extends Cubit<ContactState> {
  ContactController() : super(ContactInitial());

  final ContactService _service = ContactService();

  Future<void> fetchContacts() async {
    emit(ContactLoading());
    await Future.delayed(Duration(seconds: 2));
    final result = await _service.getContacts();
    if (!isClosed) {
      result.fold(
        (contacts) => emit(ContactLoaded(contacts)),
        (error) => emit(ContactError(error.toString())),
      );
    }
  }

  Future<void> deleteContact(Contact contact) async {
    final result = await _service.deleteContact(contact);
    if (!isClosed) {
      result.fold(
        (message) => emit(ContactDeleted(message)),
        (error) => emit(ContactError(error.toString())),
      );
    }
  }
}

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  ContactLoaded(this.contacts);

  final List<Contact> contacts;
}

class ContactDeleted extends ContactState {
  ContactDeleted(this.message);

  final String message;
}

class ContactError extends ContactState {
  ContactError(this.message);

  final String message;
}
