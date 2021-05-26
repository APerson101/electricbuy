import 'package:electricbuy/_internal/components/scrolling_flex_view.dart';
import 'package:electricbuy/purchase_bloc/bloc/purchase_bloc.dart';
import 'package:electricbuy/styled_components/styled_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ConstrainedFlexView(850,
            scrollPadding: EdgeInsets.only(right: Insets.m), child: form()));
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
          FormBuilderTextField(
              name: 'Phone',
              decoration: InputDecoration(labelText: 'Enter Phone Number'),
              validator: FormBuilderValidators.required(context),
              keyboardType: TextInputType.number),
          FormBuilderTextField(
              name: 'Meter',
              decoration: InputDecoration(labelText: 'Enter Meter Number'),
              validator: FormBuilderValidators.required(context),
              keyboardType: TextInputType.number),
          FormBuilderTextField(
              name: 'Amount',
              decoration: InputDecoration(labelText: 'Enter Amount to buy'),
              validator: FormBuilderValidators.required(context),
              keyboardType: TextInputType.number),
          ElevatedButton(
              onPressed: () async {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  print(_formKey.currentState.value);
                  await Dialogs.show(OkCancelDialog(
                    title: "Confirm Purchase",
                    message: "Are you sure you want to make this purchase",
                    onOkPressed: () {
                      rootNav.pop<bool>(true);
                      submit(_formKey.currentState.value);
                    },
                    onCancelPressed: () => rootNav.pop<bool>(false),
                  ));
                }
              },
              child: Text('Submit'))
        ],
      ),
    );
  }

  submit(Map<String, dynamic> values) {
    //validate with the api
    rootNav.push(MaterialPageRoute(builder: (BuildContext context) {
      return Purchase();
    }));
  }
}

class Purchase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) {
      var it = PurchaseBloc();
      it.add(InitializePurchase());
      return it;
    }, child: BlocBuilder(builder: (context, state) {
      if (state is PurchaseSucessful) {
        //display code, text it to them and then save to database

      }
      if (state is PurchaseFail) {
        //ask them to check the credentials of what they entered
      }
      return CircularProgressIndicator();
    }));
  }
}
