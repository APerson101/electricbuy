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
          return form();
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
    return Stack(
      children: [
        // Image.asset('assets/images/bckg.png'),
        SizedBox(
            width: context.width,
            height: context.height,
            child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcfTMf8IDP92yFSdI6RvX0a68HAX5NChSwjb1tkARtw-xQ1enwTX2DEvKDFynsbJYGYno&usqp=CAU",
                fit: BoxFit.fill)), // (
        //   "https://image.freepik.com/free-photo/conceptual-image-glowing-energy-saving-bulb-old-dark-bulbs-wires-green-background_454047-1945.jpg",
        //   fit: BoxFit.fill,
        // ),
        FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Buy  Electricity from the comfort fo your home!!",
                style: TextStyles.CalloutFocus.bold.size(40),
                textAlign: TextAlign.center,
              ),
              GFDropdown(
                  hint: Text("Select State"),
                  items: states(),
                  onChanged: (value) => controller.state.value = value),
              Container(
                  width: 500,
                  child: FormBuilderTextField(
                    name: 'Meter',
                    decoration:
                        InputDecoration(labelText: 'Enter Meter Number'),
                    validator: FormBuilderValidators.required(context),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.meter_number.value = value,
                  )),
              Container(
                width: 500,
                child: FormBuilderTextField(
                    name: 'Amount',
                    decoration:
                        InputDecoration(labelText: 'Enter Amount to buy'),
                    validator: FormBuilderValidators.required(context),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.amount.value = value),
              ),
              Container(
                width: 500,
                height: 75,
                child: ElevatedButton(
                    onPressed: () async {
                      var response = await controller.verifyMeter();
                      showMessage(response);
                    },
                    child: Text(
                      'Buy',
                      style: TextStyles.CalloutFocus.bold.size(30),
                    )),
              ),
              Text(
                "Need help? Call 07039365403",
                style: TextStyles.CalloutFocus.bold.size(20),
              )
            ],
          ),
        ),
      ],
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
