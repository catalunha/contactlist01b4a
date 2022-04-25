import 'dart:io';

import 'package:contactlist01b4a/app/data/datasources/back4app/repositories/contact_repository.dart';
import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ContactRepositoryB4a extends GetxService implements ContactRepository {
  final LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;
  @override
  void subscribe(
      {required RxList<ContactModel> list, Pagination? pagination}) async {
    if (subscription != null) {
      unSubscribe();
    }
    final query = await getQuery(pagination);
    findOld(list, query);
    subscription = await liveQuery.client.subscribe(query);
    subscriptionCreate(list);
    subscriptionUpdate(list);
    subscriptionEnter(list);
    subscriptionLeave(list);
    subscriptionDelete(list);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    unSubscribe();
    super.onClose();
  }

  void unSubscribe() {
    liveQuery.client.unSubscribe(subscription!);
  }

  void subscriptionCreate(RxList<ContactModel> list) {
    subscription!.on(LiveQueryEvent.create, (value) async {
      print(
          '*** CREATE ***: ${DateTime.now().toString()}. Contact.id ${(value as ParseObject).objectId}');
      ContactModel contact = await modelWithSubObject(value);

      list.add(contact);
    });
  }

  void subscriptionUpdate(RxList<ContactModel> list) {
    subscription!.on(LiveQueryEvent.update, (value) async {
      print(
          '*** UPDATE ***: ${DateTime.now().toString()}. Contact.id ${(value as ParseObject).objectId}');
      ContactModel contact = await modelWithSubObject(value);
      list.removeWhere((element) => element.id == contact.id);
      list.add(contact);
    });
  }

  void subscriptionEnter(RxList<ContactModel> list) {
    subscription!.on(LiveQueryEvent.enter, (value) async {
      print(
          '*** ENTER ***: ${DateTime.now().toString()}. Contact.id ${(value as ParseObject).objectId}');

      ContactModel contact = await modelWithSubObject(value);
      list.add(contact);
    });
  }

  void subscriptionLeave(RxList<ContactModel> list) {
    subscription!.on(LiveQueryEvent.leave, (value) async {
      print(
          '*** LEAVE ***: ${DateTime.now().toString()}. Contact.id ${(value as ParseObject).objectId}');
      list.removeWhere((element) => element.id == (value).objectId);
    });
  }

  void subscriptionDelete(RxList<ContactModel> list) {
    subscription!.on(LiveQueryEvent.delete, (value) async {
      print(
          '*** DELETE ***: ${DateTime.now().toString()}. Contact.id ${(value as ParseObject).objectId}');

      list.removeWhere((element) => element.id == (value).objectId);
    });
  }

  Future<QueryBuilder<ParseObject>> getQuery(Pagination? pagination) async {
    QueryBuilder<ParseObject> queryContact =
        QueryBuilder<ParseObject>(ParseObject('Contact'));
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    queryContact.whereEqualTo('createdByUser', currentUser);
    queryContact.orderByAscending('name');
    if (pagination != null) {
      queryContact.setAmountToSkip((pagination.page - 1) * pagination.limit);
      queryContact.setLimit(pagination.limit);
    }
    queryContact.includeObject(['address']);
    return queryContact;
  }

  Future<ContactModel> modelWithSubObject(ParseObject value) async {
    if ((value).get('address') != null) {
      await (value).get('address').fetch();
    }
    final contactNew = ContactModel.fromParse(value);
    return contactNew;
  }

  @override
  Future<void> create(ContactModel contactModel, XFile? _xfile) async {
    final contact = ParseObject('Contact');
    contact.set('name', contactModel.name);
    contact.set('birthday', contactModel.birthday);
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    contact.set('createdByUser', currentUser);
    if (_xfile != null) {
      String fileName = _xfile.name;
      fileName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9]'), '_');
      ParseFileBase? parseFile;
      print('===> fileName: $fileName');
      if (kIsWeb) {
        //Flutter Web
        parseFile = ParseWebFile(await _xfile.readAsBytes(),
            name: fileName); //Name for file is required
      } else {
        //Flutter Mobile/Desktop
        parseFile = ParseFile(File(_xfile.path), name: fileName);
      }
      await parseFile.save();
      contact.set('photo', parseFile);
    }
    await contact.save();
  }

  @override
  Future<void> delete(String id) async {
    var todo = ParseObject('Contact')..objectId = id;
    await todo.delete();
  }

  Future<void> findOld(
      RxList<ContactModel> list, QueryBuilder<ParseObject> query) async {
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ContactModel> contactList = [];
      contactList =
          apiResponse.results!.map((e) => ContactModel.fromParse(e)).toList();
      list.addAll(contactList);
    }
  }

  @override
  Future<List<ContactModel>> list(Pagination pagination) async {
    QueryBuilder<ParseObject> queryContact =
        QueryBuilder<ParseObject>(ParseObject('Contact'));
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    queryContact.whereEqualTo('createdByUser', currentUser);
    queryContact.orderByAscending('name');
    queryContact.setAmountToSkip((pagination.page - 1) * pagination.limit);
    queryContact.setLimit(pagination.limit);
    queryContact.includeObject(['address']);
    final ParseResponse apiResponse = await queryContact.query();
    if (apiResponse.success && apiResponse.results != null) {
      print(apiResponse.results![0].objectId);
      // print(apiResponse.results![0].get('name'));
      // print(apiResponse.results![0].get('photo'));
      // print(apiResponse.results![0].get('photo').get('url'));
      // print(apiResponse.results![0].get('birthday'));
      // print(apiResponse.results![0].get('address'));
      // print(apiResponse.results![0].get('address').get('cep'));
      // for (var item in apiResponse.results!) {
      //   print(item.toString());
      // }
      List<ContactModel> contactList = [];
      contactList =
          apiResponse.results!.map((e) => ContactModel.fromParse(e)).toList();
      // for (var item in contactList) {
      //   print(item.toString());
      // }
      // list.
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
  Future<void> update(ContactModel contactModel, XFile? _xfile) async {
    final contact = ParseObject('Contact');
    contact.objectId = contactModel.id;
    contact.set('name', contactModel.name);
    contact.set('birthday', contactModel.birthday);
    var currentUser = await ParseUser.currentUser() as ParseUser?;
    contact.set('createdByUser', currentUser);

    if (_xfile != null) {
      String fileName = _xfile.name;
      fileName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9]'), '_');
      ParseFileBase? parseFile;
      if (kIsWeb) {
        //Flutter Web
        parseFile = ParseWebFile(await _xfile.readAsBytes(),
            name: fileName); //Name for file is required
      } else {
        //Flutter Mobile/Desktop
        parseFile = ParseFile(File(_xfile.path), name: fileName);
      }
      await parseFile.save();
      contact.set('photo', parseFile);
    }
    await contact.save();
  }

  @override
  Future<void> updateAddress(String contactId, String addressId) async {
    final contact = ParseObject('Contact');
    contact.objectId = contactId;
    final address = ParseObject('Address');
    address.objectId = addressId;
    contact.set('address', address);
    await contact.save();
  }
}
