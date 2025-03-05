import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/contact.service.dart';
import '../models/contact.model.dart';

class NewContactController extends Cubit<NewContactState> {
  final ContactService contactService;

  NewContactController(this.contactService) : super(NewContactInitial());

  Future<void> createContact(Contact contact) async {
    emit(NewContactLoading());
    try {
      final result = await contactService.createContact(contact);
      result.fold(
        (failure) {
          log('Falha ao criar contato: $failure');
          emit(NewContactError(failure));
        },
        (success) {
          log('Contato criado com sucesso');
          emit(NewContactLoaded());
        },
      );
    } catch (e) {
      log('Erro ao criar contato: $e');
      emit(NewContactError('Erro: $e'));
    }
  }
}

abstract class NewContactState {}

class NewContactInitial extends NewContactState {}

class NewContactLoading extends NewContactState {}

class NewContactLoaded extends NewContactState {}

class NewContactError extends NewContactState {
  NewContactError(this.message);

  final String message;
}
