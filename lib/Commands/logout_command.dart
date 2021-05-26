import 'package:electricbuy/Commands/websignin.dart';
import 'package:electricbuy/_internal/page_routes.dart';
import 'package:electricbuy/commands/abstractComand.dart';
import 'package:electricbuy/models/app_model.dart';
import 'package:electricbuy/styled_components/styled_dialogs.dart';
import 'package:electricbuy/themes.dart';
import 'package:electricbuy/views/welcome/welcome_page.dart';
import 'package:flutter/cupertino.dart';

class LogoutCommand extends AbstractCommand {
  BuildContext context;
  LogoutCommand(BuildContext context) : super(context) {
    this.context = context;
  }

  Future<void> execute({bool doConfirm = false}) async {
    // Log.p("[LogoutCommand]");

    if (doConfirm) {
      bool doLogout = await Dialogs.show(OkCancelDialog(
        title: "Sign Out?",
        message: "Are you sure you want to sign-out?",
        onOkPressed: () => rootNav.pop<bool>(true),
        onCancelPressed: () => rootNav.pop<bool>(false),
      ));
      if (!doLogout) return;
    }

    // //Quietly clear out various models.
    // // Don't notify listeners, as we don't want the views to clear until we've fully transitioned out

    await WebSignIn(context).executeSignOut();

    // //Reset the theme and app settings

    appModel.theme = ThemeType.FlockGreen;

    //Show login page
    rootNav.pushReplacement(
        PageRoutes.fade(() => WelcomePage(initialPanelOpen: true)));
  }
}
