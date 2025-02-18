import 'package:contact_app/android/core/utils/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import '../../models/contact.model.dart';
import '../interfaces/contact.interface.dart';
import 'service.dart';

class ContactService extends BaseService implements IContactService {
  ContactService() : super('https://gorest.co.in/public/v2');

  @override
  AsyncResult<List<Contact>> getContacts() async {
    try {
      final response = await get('/users');
      final List<dynamic> data = response.data;
      final contacts = data.map((json) => Contact.fromMap(json)).toList();
      return Success(contacts);
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao carregar contatos'),
      );
    }
  }

  @override
  AsyncResult<String> deleteContact(Contact contact) async {
    try {
      final response = await delete('/users/${contact.id}');
      if (response.statusCode == 204) {
        return Success('Contato deletado com sucess');
      }
      return Failure(GeneralException('Usuário não encontrado.'));
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao deletar contato'),
      );
    }
  }

  @override
  AsyncResult<String> updateContact(Contact contact) async {
    try {
      final response = await put('/users/${contact.id}', contact.toMap());
      if (response.statusCode == 200) {
        return Success('Contato atualizado com sucesso');
      }
      return Failure(GeneralException('Erro ao atualizar contato'));
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao atualizar contato'),
      );
    }
  }
}
