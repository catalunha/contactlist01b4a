import 'package:contactlist01b4a/app/app.dart';
import 'package:contactlist01b4a/app/data/datasources/back4app/init_back4app.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // const keyApplicationId = 'x4uHx8hJECtAPiKo4Z2f8IK9OUKRtcuUBBaUBHM9';
  // const keyParseServerUrl = 'https://parseapi.back4app.com';
  // const keyClientKey = 'GoHjfXQ1fIClRQ6K9Gg9hc1dpKj90HJGRXcHeSrs';
  // await Parse().initialize(
  //   keyApplicationId,
  //   keyParseServerUrl,
  //   clientKey: keyClientKey,
  //   autoSendSessionId: true,
  //   debug: true,
  // );
  InitBack4app initBack4app = InitBack4app();
  await initBack4app.init();
  var contact = ParseObject('Contact');
  contact.set('name', 'Flutter Android - teste 5');
  await contact.save();
  runApp(const App());
}
