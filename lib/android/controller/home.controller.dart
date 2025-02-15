import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../core/services/contact.service.dart';
import '../models/contact.model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    fetchContacts();
  }

  final ContactService _service = ContactService();

  AsyncResult<List<Contact>> fetchContacts() async {
    emit(HomeLoading());
    final result = await _service.getContacts();
    result.fold(
      (contacts) => emit(HomeLoaded(contacts)),
      (error) => emit(HomeError(error.toString())),
    );
    return result;
  }
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.contacts);

  final List<Contact> contacts;
}

class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}
