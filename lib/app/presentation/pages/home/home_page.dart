import 'package:contactlist01b4a/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:contactlist01b4a/app/presentation/pages/home/part/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final SplashController _splashController = Get.find();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QueryBuilder<ParseObject> queryContact =
        QueryBuilder<ParseObject>(ParseObject('Contact'));
    // var currentUser = await ParseUser.currentUser() as ParseUser?;
    // queryContact.whereEqualTo('createdByUser', currentUser);
    queryContact.orderByAscending('name');
    // queryContact.setAmountToSkip((pagination.page - 1) * pagination.limit);
    // queryContact.setLimit(pagination.limit);
    queryContact.includeObject(['address']);

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home'),
        title: Obx(() => Text(
              // 'Olá, ${widget._homeController.userService.userModel.displayName ?? "Sem nome"}',
              'Olá,\n${_splashController.userModel?.username ?? "Sem nome"}',
              // 'Oi, ${widget._userService.userModel.uuid}',

              style: const TextStyle(color: Colors.black),
            )),
        actions: [
          IconButton(
            onPressed: () async {
              int qtde = await _homeController.countContacts();
              Get.snackbar(
                'Count via CloudCoud',
                'Quantidade de contatos: $qtde',
                backgroundColor: Colors.green,
                margin: const EdgeInsets.all(10),
              );
            },
            icon: const Icon(Icons.format_list_numbered),
          ),
          IconButton(
            onPressed: () => _homeController.logout(),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      // body: ParseLiveListWidget<ParseObject>(
      //   query: queryContact,
      //   reverse: false,
      //   childBuilder: (BuildContext context,
      //       ParseLiveListElementSnapshot<ParseObject> snapshot) {
      //     if (snapshot.failed) {
      //       return const Text('something went wrong!');
      //     } else if (snapshot.hasData) {
      //       final contact = ContactModel.fromParse(snapshot.loadedData!);
      //       return ContactInfo(contact: contact);
      //       // return ListTile(
      //       //   title: Text(
      //       //     snapshot.loadedData!.get("name"),
      //       //   ),
      //       // );
      //     } else {
      //       return const ListTile(
      //         leading: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   color: Colors.black12,
          //   alignment: Alignment.center,
          //   child: const Text(
          //       'ScrollUp para ver mais itens. Na Web com problemas'),
          // ),
          Expanded(
            child: Obx(() => ContactList(
                  contacts: _homeController.contacts,
                  nextPage: () => _homeController.nextPage(),
                  lastPage: _homeController.lastPage,
                )),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: _homeController.contacts.length,
      //   itemBuilder: (context, index) {
      //     final contact = _homeController.contacts[index];
      //     return ListTile(
      //       title: Text(contact.name),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: context.primaryColor,
        onPressed: () {
          _homeController.createContact();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
