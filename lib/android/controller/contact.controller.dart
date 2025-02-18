import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/services/contact.service.dart';
import '../models/contact.model.dart';

class ContactController extends Cubit<ContactState> {
  ContactController() : super(ContactInitial());

  final ContactService _service = ContactService();
  List<Contact> _contacts = [];

  Future<void> fetchContacts() async {
    emit(ContactLoading());
    await Future.delayed(Duration(seconds: 2));
    final result = await _service.getContacts();
    if (!isClosed) {
      result.fold(
        (contacts) {
          _contacts = contacts;
          emit(ContactLoaded(_contacts));
        },
        (error) => emit(ContactError(error.toString())),
      );
    }
  }

  Future<void> deleteContact(Contact contact) async {
    final result = await _service.deleteContact(contact);
    if (!isClosed) {
      result.fold(
        (message) {
          _contacts.removeWhere((c) => c.id == contact.id);
          emit(ContactDeleted(message));
          emit(ContactLoaded(_contacts));
        },
        (error) => emit(ContactDeleteError(error.toString())),
      );
    }
  }

  Future<void> updateContact(Contact contact) async {
    final result = await _service.updateContact(contact);
    if (!isClosed) {
      result.fold(
        (message) {
          final index = _contacts.indexWhere((c) => c.id == contact.id);
          if (index != -1) {
            _contacts[index] = contact;
          }
          emit(ContactUpdated(message));
          emit(ContactLoaded(_contacts));
        },
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

class ContactDeleteError extends ContactState {
  ContactDeleteError(this.message);

  final String message;
}

class ContactUpdated extends ContactState {
  ContactUpdated(this.message);

  final String message;
}
