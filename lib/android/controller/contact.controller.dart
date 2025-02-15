import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../core/services/contact.service.dart';
import '../models/contact.model.dart';

class ContactController extends Cubit<ContactState> {
  ContactController() : super(ContactInitial()) {
    fetchContacts();
  }

  final ContactService _service = ContactService();

  AsyncResult<List<Contact>> fetchContacts() async {
    emit(ContactLoading());
    final result = await _service.getContacts();
    result.fold(
      (contacts) => emit(ContactLoaded(contacts)),
      (error) => emit(ContactError(error.toString())),
    );
    return result;
  }
}

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  ContactLoaded(this.contacts);

  final List<Contact> contacts;
}

class ContactError extends ContactState {
  ContactError(this.message);

  final String message;
}
