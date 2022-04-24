import 'package:contactlist01b4a/app/domain/models/address_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';

abstract class AddressRepository {
  Future<String> create(AddressModel contactModel);
  Future<List<AddressModel>> list(Pagination pagination);
  Future<AddressModel?> readById(String id);
  Future<String> update(AddressModel contactModel);
  Future<void> delete(String id);
}
