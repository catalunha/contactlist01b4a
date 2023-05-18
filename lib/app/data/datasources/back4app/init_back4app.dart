import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class InitBack4app {
  InitBack4app() {
    // init();
  }

  Future<bool> init() async {
    const _keyApplicationId = '';
    const _keyParseServerUrl = 'https://parseapi.back4app.com';
    const _keyClientKey = '';
    const _keyLiveQueryUrl = 'https://contactlist01.b4a.io';
    await Parse().initialize(
      _keyApplicationId, _keyParseServerUrl,
      clientKey: _keyClientKey,
      liveQueryUrl: _keyLiveQueryUrl,
      autoSendSessionId: true,
      // debug: true,
    );
    return (await Parse().healthCheck()).success;
  }
}
