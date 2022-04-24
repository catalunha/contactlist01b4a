import 'package:contactlist01b4a/app/domain/models/address_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';

abstract class AddressUseCase {
  Future<String> create(AddressModel addressModel);
  Future<List<AddressModel>> list(Pagination pagination);
  Future<AddressModel?> readById(String id);
  Future<String> update(AddressModel addressModel);
  Future<void> delete(String id);
}
