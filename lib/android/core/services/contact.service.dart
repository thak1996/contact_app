import 'package:contact_app/android/core/utils/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import '../../models/contact.model.dart';
import '../interfaces/contact.interface.dart';
import '../utils/error.translator.dart';
import 'dio.service.dart';

class ContactService extends BaseService implements IContactService {
  ContactService();

  @override
  AsyncResult<List<Contact>> getContacts() async {
    try {
      final response = await get(route: '/users');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final contacts = data.map((json) => Contact.fromMap(json)).toList();
        return Success(contacts);
      } else {
        return Failure(GeneralException('Erro ao carregar contatos'));
      }
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao carregar contatos'),
      );
    }
  }

  @override
  AsyncResult<String> deleteContact(Contact contact) async {
    try {
      final response = await delete(route: '/users/${contact.id}');
      if (response.statusCode == 204) Success('Contato deletado com sucesso');
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
      final response = await put(
        route: '/users/${contact.id}',
        body: contact.toMap(),
      );
      if (response.statusCode == 200) Success('Contato atualizado com sucesso');
      return Failure(GeneralException('Erro ao atualizar contato'));
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao atualizar contato'),
      );
    }
  }

  @override
  AsyncResult<String> createContact(Contact contact) async {
    try {
      final response = await post(route: '/users', body: contact.toMap());
      if (response.statusCode == 201) Success('Contato criado com sucesso');
      if (response.data is List) {
        final listErrors = response.data as List;
        final translatedErrors = ErrorTranslator.translateList(listErrors);
        return Failure(GeneralException(translatedErrors));
      }
      return Failure(GeneralException('Erro ao criar contato'));
    } on DioException catch (e) {
      return Failure(
        GeneralException(e.message ?? 'Erro ao criar contato'),
      );
    }
  }
}
