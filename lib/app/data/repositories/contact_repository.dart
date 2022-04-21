import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:image_picker/image_picker.dart';

abstract class ContactRepository {
  Future<void> create(ContactModel contactModel, XFile? _xfile);
  Future<List<ContactModel>> list(Pagination pagination);
  Future<ContactModel?> readById(String id);
  Future<void> update(ContactModel contactModel, XFile? _xfile);
  Future<void> delete(String id);
}
