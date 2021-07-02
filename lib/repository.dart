import 'package:electricbuy/APIHandler.dart';

import 'models/Power.dart';

class PurchaseRepository extends APIHandler {
  var name;
  buyPower(Power power) async {
    var response = _buyPower(power);
    return response;
  }

  Future<List> verifyMeter(Power power) async {
    var response =
        await callFunction(body: power.toMap(), function: "verifyMeter");
    if (response["status"] == true) {
      name = response["data"]["name"];
      return [true, name];
    }
    return [false, null];
  }

  _buyPower(Power power) async {
    var response =
        await callFunction(body: power.toMap(), function: "buyPower");
    if (response["status"] == true) {
      name = response["data"]["data"];
      return [true, null];
    }
    return [false, response["server_message"]];
  }
}
