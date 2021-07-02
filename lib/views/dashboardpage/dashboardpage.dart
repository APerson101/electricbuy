import 'package:electricbuy/_internal/components/scrolling_flex_view.dart';
import 'package:electricbuy/purchase_bloc/bloc/purchase_bloc.dart';
import 'package:electricbuy/styled_components/styled_dialogs.dart';
import 'package:electricbuy/views/dashboardpage/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getwidget/getwidget.dart';

import '../../globals.dart';
import '../../styles.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  NavigatorState get rootNav => AppGlobals.nav;
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    print('rebuilding');
    return Container(
        child: ConstrainedFlexView(850,
            scrollPadding: EdgeInsets.only(right: Insets.m),
            child: Center(child: Obx(() {
      switch (controller.currentState.value) {
        case viewState.dashboard:
          return gridItems();
          break;
        case viewState.loading:
          return CircularProgressIndicator();
        case viewState.powerForm:
          return form();

        default:
          return Container();
      }
    }))));
  }

  gridItems() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      //show form
                      controller.currentState.value = viewState.powerForm;
                    },
                    child: Text("Buy Power"))),
            Expanded(
                child:
                    ElevatedButton(onPressed: () {}, child: Text("Buy Data")))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Subscribe Cable TV"))),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Buy Airtime")))
          ],
        ),
      ],
    );
  }

  form() {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text(
            "Buy Your Electricity Here!",
            style: TextStyles.CalloutFocus.bold.size(24),
            textAlign: TextAlign.center,
          ),
          GFDropdown(
              items: states(),
              onChanged: (value) => controller.state.value = value),
          FormBuilderTextField(
            name: 'Meter',
            decoration: InputDecoration(labelText: 'Enter Meter Number'),
            validator: FormBuilderValidators.required(context),
            keyboardType: TextInputType.number,
            onChanged: (value) => controller.meter_number.value = value,
          ),
          FormBuilderTextField(
              name: 'Amount',
              decoration: InputDecoration(labelText: 'Enter Amount to buy'),
              validator: FormBuilderValidators.required(context),
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.amount.value = value),
          ElevatedButton(
              onPressed: () async {
                var response = await controller.verifyMeter();
                showMessage(response);
              },
              child: Text('Buy'))
        ],
      ),
    );
  }

  states() {
    return [
      'FCT',
      'Kogi',
      'Nasarawa',
      'Niger',
      'Kaduna',
      'Kebbi',
      'Sokoto',
      'zamfara',
      'Kano',
      'Katsina',
      'Jigawa',
      'Bauchi',
      'Benue',
      'Gombe',
      'Plateau',
      'Abia',
      'Enugu',
      'Imo',
      'Ebonyi',
      'Anambra',
      'Akwa Ibom',
      'Bayelsa',
      'Rivers',
      'Cross Rivers',
      'Oyo',
      'Osun',
      "Lagos",
      "Ogun"
    ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();
  }

  showMessage(bool status) {
    if (status) {
      Get.defaultDialog(
          title: "Confirm purchase",
          onCancel: () => Get.back(),
          onConfirm: () async {
            Get.back();
            var value = await controller.confirmPurchase();
            if (value) {
              Get.snackbar('success', 'Credit purchase successfully');

              //show the thing...
            } else
              showFailedDialog();
          },
          content: Container(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("confirm purchase of Power"),
                    Text("to"),
                    Text("${controller.meter_name.value}"),
                    Text("amount in Naira: ${controller.amount}"),
                  ]),
            ),
          ));
    } else {
      Get.defaultDialog(
          title: "Invalid Meter Number",
          content: Text("You entered an Invalid meter number"),
          onConfirm: () => Get.back(),
          onCancel: () => Get.back());
    }
  }

  showFailedDialog() {
    Get.defaultDialog(
        title: "Info", content: Text(controller.errorMessage.value));
  }
}
