import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../core/services/contact.service.dart';
import '../models/contact.model.dart';

class HomeCubit extends Cubit<HomeState> {
  final ContactService _service = ContactService();

  HomeCubit() : super(HomeInitial());

  AsyncResult<List<Contact>> fetchContacts() async {
    emit(HomeLoading());
    final result = await _service.getContacts();
    result.fold(
      (contacts) {
        log('Contatos carregados: $contacts');
        emit(HomeLoaded(contacts));
      },
      (error) => emit(HomeError(error.toString())),
    );
    return result;
  }
}

// Estados
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Contact> contacts;
  HomeLoaded(this.contacts);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
