import 'package:electricbuy/models/Power.dart';
import 'package:electricbuy/repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController {
  PurchaseRepository repository = PurchaseRepository();
//power details
  var state = 'FCT'.obs;
  var meter_number = ''.obs;
  var amount = ''.obs;
  var currentState = viewState.dashboard.obs;
  String product_code;
  var meter_name = ''.obs;

//power details end

  verifyMeter() async {
    currentState.value = viewState.loading;
    // mobile_topup
    // data_topup
    // broadband_internet
    // cable_subscription
    List lagCodes;
    bool lagos = false;
//     abuja_distribution_company
// ibadan_distribution_company
// abuja_distribution_company
// kaduna_distribution_company
// kano_distribution_company
// jos_distribution_company
// ikeja_distribution_company
// eko_distribution_company
// enugu_distribution_company
// port_harcourt_distribution_company

// ibadan_distribution_company_postpaid
// ibadan_distribution_company_prepaid
// abuja_distribution_company_postpaid
// abuja_distribution_company_prepaid
// kaduna_distribution_company_postpaid
// kaduna_distribution_company_prepaid
// kano_distribution_company_prepaid
// kano_distribution_company_postpaid
// jos_distribution_company_prepaid
// jos_distribution_company_postpaid
// ikeja_distribution_company_postpaid
// ikeja_distribution_company_prepaid

// eko_distribution_company_postpaid
// eko_distribution_company_prepaid
// enugu_distribution_company_postpaid
// enugu_distribution_company_prepaid
// port_harcourt_distribution_company_postpaid
// port_harcourt_distribution_company_prepaid

// ibedc_prepaid_custom=oyo, osun, ogun
// var aedc_prepaid_custom =["FCT","kogi", "Nasarawa", "Niger"];
// knedc_prepaid_custom=Kaduna, kebbi, sokoto, zamfara
// kano_prepaid_custom-Kano, katsina, jigawa
// jedc_prepaid_custom=Bauchi, Benue, Gombe, plateau
// eedc_prepaid_custom=Abia\nAnambra\nEnugu\nEbonyi\nImo
// phed_prepaid_custom=Akwa Ibom\nBayelsa\nCross Rivers\nRivers

// ikedc_prepaid_custom=Abule Egba\nAkowonjo\nIkeja\nIkorodu\nOshodi\nShomolu
// ekedc_prepaid_custom=(Ojo,Festac, Ijora, Mushin (also covers Orile areas),Apapa, Lekki (also covers Ibeju areas)\nLagos Island(also covers Ajele areas) \nPart of Ogun State (Agbara)

    if (state.value == 'FCT' ||
        state.value == 'Kogi' ||
        state.value == 'Nasarawa' ||
        state.value == 'Niger') {
      product_code = 'aedc_prepaid_custom';
    } else if (state.value == 'Kaduna' ||
        state.value == 'Kebbi' ||
        state.value == 'Sokoto' ||
        state.value == 'zamfara') {
      product_code = 'knedc_prepaid_custom';
    } else if (state.value == 'Kano' ||
        state.value == 'Katsina' ||
        state.value == 'Jigawa') {
      product_code = 'kano_prepaid_custom';
    } else if (state.value == 'Bauchi' ||
        state.value == 'Benue' ||
        state.value == 'Gombe' ||
        state.value == 'Plateau') {
      product_code = 'jedc_prepaid_custom';
    } else if (state.value == 'Abia' ||
        state.value == 'Enugu' ||
        state.value == 'Imo' ||
        state.value == 'Ebonyi' ||
        state.value == 'Anambra') {
      product_code = 'eedc_prepaid_custom';
    } else if (state.value == 'Akwa Ibom' ||
        state.value == 'Bayelsa' ||
        state.value == 'Rivers' ||
        state.value == 'Cross Rivers') {
      product_code = 'phed_prepaid_custom';
    } else if (state.value == 'Oyo' || state.value == 'Osun') {
      product_code = 'ibedc_prepaid_custom';
    } else if (state.value == "Lagos" || state.value == "Ogun") {
      lagos = true;
      lagCodes = [
        "ibedc_prepaid_custom",
        "ikedc_prepaid_custom",
        "ekedc_prepaid_custom"
      ];
    }
    if (!lagos) {
      List response = await repository.verifyMeter(Power(
          amount: this.amount.value,
          meter_number: this.meter_number.value,
          product_code: product_code));
      if (response[0]) {
        meter_name.value = response[1];
        currentState.value = viewState.dashboard;

        return true;
      }
      currentState.value = viewState.dashboard;

      return false;
    }
    if (lagos) {
      for (var code in lagCodes) {
        List response = await repository.verifyMeter(Power(
            amount: this.amount.value,
            meter_number: this.meter_number.value,
            product_code: code));
        if (response[0]) {
          meter_name.value = response[1];
          currentState.value = viewState.dashboard;
          return true;
        }
        currentState.value = viewState.dashboard;
        return false;
      }
    }
  }

  confirmPurchase() async {
    currentState.value = viewState.loading;
    var response = await repository.buyPower(Power(
        amount: this.amount.value,
        product_code: this.product_code,
        meter_number: this.meter_number.value));
    currentState.value = viewState.dashboard;

    if (response[0]) {
      return true;
    } else if (!response[0]) {
      errorMessage.value = response[1];
      return false;
    }
  }

  var errorMessage = ''.obs;
}

enum viewState {
  loading,
  CompleteSuccess,
  powerForm,
  dataForm,
  cableForm,
  AirtimeForm,
  failure,
  dashboard
}
