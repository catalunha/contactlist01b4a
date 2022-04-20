import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ContactList extends StatelessWidget {
  final List<ContactModel> contacts;
  final Function() nextPage;
  final bool lastPage;
  const ContactList(
      {Key? key,
      required this.contacts,
      required this.nextPage,
      required this.lastPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: () => nextPage(),
      isLoading: lastPage,
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
          );
        },
      ),
    );
  }
}
