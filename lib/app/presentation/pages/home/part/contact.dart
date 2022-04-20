import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactInfo extends StatelessWidget {
  final HomeController _homeController = Get.find();

  final ContactModel contactModel;
  ContactInfo({Key? key, required this.contactModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contactModel.name),
      subtitle: Text(contactModel.id),
      onTap: () {
        print('click');
        _homeController.editContact(contactModel.id);
      },
    );
  }
}
