import 'package:contactlist01b4a/app/data/datasources/back4app/address/address_repository_exception.dart';
import 'package:contactlist01b4a/app/data/repositories/address_repository.dart';
import 'package:contactlist01b4a/app/domain/models/address_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AddressRepositoryB4a implements AddressRepository {
  @override
  Future<String> create(AddressModel addressModel) async {
    final contact = addressModel.toParse();
    ParseResponse parseResponse = await contact.save();
    if (parseResponse.success && parseResponse.results != null) {
      print(parseResponse.results![0].objectId);
      return parseResponse.results![0].objectId;
    } else {
      throw AddressRepositoryException(message: 'Erro ao criar address');
    }
  }

  @override
  Future<void> delete(String id) async {
    var todo = ParseObject('Address')..objectId = id;
    await todo.delete();
  }

  @override
  Future<List<AddressModel>> list(Pagination pagination) async {
    throw AddressRepositoryException(
      message: 'lista de endereços nao implementada',
    );
  }

  @override
  Future<AddressModel?> readById(String id) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<String> update(AddressModel addressModel) async {
    final contact = addressModel.toParse();
    ParseResponse parseResponse = await contact.save();
    if (parseResponse.success && parseResponse.results != null) {
      print(parseResponse.results![0].objectId);
      return parseResponse.results![0].objectId;
    } else {
      throw AddressRepositoryException(message: 'Erro ao criar address');
    }
  }
}
