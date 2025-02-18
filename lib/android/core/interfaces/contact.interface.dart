import 'package:result_dart/result_dart.dart';
import '../../models/contact.model.dart';

abstract class IContactService {
  AsyncResult<List<Contact>> getContacts();
  AsyncResult<String> deleteContact(Contact contact);
}
