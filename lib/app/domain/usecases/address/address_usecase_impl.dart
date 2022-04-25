import 'package:contactlist01b4a/app/data/datasources/back4app/repositories/address_repository.dart';
import 'package:contactlist01b4a/app/domain/models/address_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/address/address_usecase.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';

class AddressUseCaseImpl implements AddressUseCase {
  final AddressRepository _addressRepository;
  AddressUseCaseImpl({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;
  @override
  Future<String> create(AddressModel addressModel) =>
      _addressRepository.create(addressModel);

  @override
  Future<void> delete(String id) => _addressRepository.delete(id);

  @override
  Future<List<AddressModel>> list(Pagination pagination) =>
      _addressRepository.list(pagination);

  @override
  Future<AddressModel?> readById(String id) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<String> update(AddressModel addressModel) =>
      _addressRepository.update(addressModel);
}
