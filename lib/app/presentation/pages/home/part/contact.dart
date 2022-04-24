import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContactInfo extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final dateFormat = DateFormat('dd/MM/y');

  final ContactModel contact;
  ContactInfo({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:
                  // _homeController.userModel.photoUrl != null
                  //     ?
                  Image.network(
                contact.photo ?? '',
                // loadingBuilder: (_, __, ___) {
                //   return Center(child: const CircularProgressIndicator());
                // },
                height: 58,
                width: 58,
                errorBuilder: (_, __, ___) {
                  return const SizedBox(
                    height: 58,
                    width: 58,
                    child: Icon(
                      Icons.person,
                    ),
                  );
                },
              ),
            ),
            title: Text('${contact.name} '),
            subtitle: Text(contact.birthday != null
                ? dateFormat.format(contact.birthday!)
                : "..."),
            onTap: () {
              print('click');
              _homeController.editContact(contact.id!);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => _homeController.editAddress(contact.id!),
                    icon: const Icon(Icons.home)),
                Text(contact.address != null
                    ? 'CEP: ${contact.address!.cep}. End.: ${contact.address!.description}'
                    : "..."),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'id: ${contact.id} ',
                // textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
