import 'package:contactlist01b4a/app/data/repositories/contact_repository.dart';
import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ContactRepositoryB4a implements ContactRepository {
  @override
  Future<void> create(ContactModel contactModel) async {
    final contact = ParseObject('Contact')..set('name', contactModel.name);
    await contact.save();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ContactModel>> list(Pagination pagination) async {
    QueryBuilder<ParseObject> queryContact =
        QueryBuilder<ParseObject>(ParseObject('Contact'));
    print('_pagination in list: $pagination');
    queryContact.orderByAscending('name');
    queryContact.setAmountToSkip((pagination.page - 1) * pagination.limit);
    queryContact.setLimit(pagination.limit);

    final ParseResponse apiResponse = await queryContact.query();
    if (apiResponse.success && apiResponse.results != null) {
      // for (var item in apiResponse.results!) {
      //   print(item.toString());
      // }
      List<ContactModel> contactList = [];
      contactList = apiResponse.results!
          .map((e) => ContactModel.fromJson(e.toString()))
          .toList();
      // for (var item in contactList) {
      //   print(item.toString());
      // }
      return contactList;
    }
    return [];
  }

  @override
  Future<ContactModel?> readById(String id) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<void> update(ContactModel contactModel) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
