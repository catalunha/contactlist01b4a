import 'package:contactlist01b4a/app/data/repositories/contact_repository.dart';
import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/contact/contact_usecase.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:image_picker/image_picker.dart';

class ContactUseCaseImpl implements ContactUseCase {
  final ContactRepository _contactRepository;
  ContactUseCaseImpl({
    required ContactRepository contactRepository,
  }) : _contactRepository = contactRepository;
  @override
  Future<void> create(ContactModel contactModel, XFile? _xfile) =>
      _contactRepository.create(contactModel, _xfile);

  @override
  Future<void> delete(String id) => _contactRepository.delete(id);

  @override
  Future<List<ContactModel>> list(Pagination pagination) =>
      _contactRepository.list(pagination);

  @override
  Future<ContactModel?> readById(String id) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<void> update(ContactModel contactModel, XFile? _xfile) =>
      _contactRepository.update(contactModel, _xfile);

  @override
  Future<void> updateAddress(String contactId, String addressId) =>
      _contactRepository.updateAddress(contactId, addressId);
}
