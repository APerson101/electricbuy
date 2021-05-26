import 'package:electricbuy/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

abstract class AbstractCommand {
  AbstractCommand(BuildContext buildContext) {
    context = Provider.of(buildContext, listen: false);
  }
  NavigatorState get rootNav => AppGlobals.nav;

  BuildContext context;

  T getProvided<T>() => Provider.of<T>(context, listen: false);
  AppModel get appModel => getProvided();
}
