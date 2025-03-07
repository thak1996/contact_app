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
      if (!isClosed) {
        result.fold(
          (success) => emit(NewContactLoaded()),
          (failure) => emit(NewContactError('$failure')),
        );
      }
    } catch (e) {
      if (!isClosed) emit(NewContactError('Erro: $e'));
    }
  }
}

sealed class NewContactState {}

final class NewContactInitial extends NewContactState {}

final class NewContactLoading extends NewContactState {}

final class NewContactLoaded extends NewContactState {}

final class NewContactError extends NewContactState {
  NewContactError(this.message);

  final String message;
}
