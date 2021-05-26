import 'package:electricbuy/_internal/components/seperated_flexibles.dart';
import 'package:electricbuy/app_extensions.dart';
import 'package:electricbuy/styled_components/buttons/primary_btn.dart';
import 'package:electricbuy/styled_components/electricbuy_logo.dart';
import 'package:electricbuy/styles.dart';
import 'package:electricbuy/views/welcome/animated_bird_splash.dart';
import 'package:electricbuy/views/welcome/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePageStep1 extends StatelessWidget {
  final bool singleColumnMode;

  const WelcomePageStep1({Key key, this.singleColumnMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomePageState state = context.watch();
    TextStyle bodyTxtStyle =
        TextStyles.Body1.textColor(Color(0xfff1f7f0)).textHeight(1.6);
    return SeparatedColumn(
      separatorBuilder: () => SizedBox(height: Insets.l),
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (singleColumnMode) ElectricbuyLogo(50, Colors.white).center(),
        if (singleColumnMode)
          AnimatedBirdSplashWidget(
                  alignment: Alignment.bottomCenter, showLogo: false)
              .padding(all: Insets.m * 1.5)
              .height(context.heightPx * .4),
        [
          Text(
            "Welcome to ElectricBuy",
            style:
                TextStyles.CalloutFocus.bold.size(24).textColor(Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            "Electricbuy is a modern platform that lets you purchase electricity for your home from any location in the world.",
            style: bodyTxtStyle,
            textAlign: TextAlign.center,
          ).padding(vertical: Insets.l),
          Text(
            "To get started, you will first need to authorize this application.",
            style: bodyTxtStyle,
            textAlign: TextAlign.center,
          ),
        ].toColumn().constrained(maxWidth: 400),
        kIsWeb
            ? Image.asset("assets/images/google-signin.png", height: 50)
                .gestures(onTap: state.handleStartPressed)
            : PrimaryTextBtn(
                "LET'S START!",
                bigMode: true,
                onPressed: state.handleStartPressed,
              ).padding(top: Insets.m).width(239),
      ],
    ).padding(vertical: Insets.l);
  }
}
