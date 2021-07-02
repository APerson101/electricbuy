import 'package:cloud_functions/cloud_functions.dart';

class APIHandler {
  APIHandler() {
    _firebaseFunctions.useFunctionsEmulator(origin: 'http://localhost:5001');
  }
  FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;
  callFunction({dynamic body, dynamic params, String function}) async {
    HttpsCallable caller = _firebaseFunctions.httpsCallable(function);
    var responseData = await caller.call({'body': body, 'params': params});
    print(responseData);
    return responseData.data;
  }
}
