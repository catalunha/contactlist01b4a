import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';

abstract class ContactUseCase {
  Future<void> create(ContactModel contactModel);
  Future<List<ContactModel>> list(Pagination pagination);
  Future<ContactModel?> readById(String id);
  Future<void> update(ContactModel contactModel);
  Future<void> delete(String id);
}
