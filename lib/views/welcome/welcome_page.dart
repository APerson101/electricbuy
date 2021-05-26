import 'dart:math';

import 'package:electricbuy/Commands/websignin.dart';
import 'package:electricbuy/_internal/components/fading_index_stack.dart';
import 'package:electricbuy/_internal/page_routes.dart';
import 'package:electricbuy/styled_components/styled_progress_spinner.dart';
import 'package:electricbuy/views/mainscaffold/mainscaffold.dart';
import 'package:electricbuy/views/welcome/animated_bird_splash.dart';
import 'package:electricbuy/views/welcome/welcome_page_step1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:electricbuy/app_extensions.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../styles.dart';
import '../../themes.dart';

class WelcomePage extends StatefulWidget {
  final bool initialPanelOpen;
  const WelcomePage({Key key, this.initialPanelOpen = false}) : super(key: key);
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  bool showContent;
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  int pageIndex = 0;

  set isLoading(bool value) => setState(() => _isLoading = value);

  Size prevSize;
  bool twoColumnMode = true;

  @override
  void initState() {
    showContent = widget.initialPanelOpen;
    super.initState();
  }

  void showPanel(value) => setState(() => showContent = value);
  refreshDataAndLoadApp() {
    isLoading = true;
    Navigator.push<void>(
        context,
        PageRoutes.fade(
            () => MainScaffold(), Durations.slow.inMilliseconds * .001));
  }

  void handleStartPressed() async {
    if (UniversalPlatform.isWeb) {
      UserCredential userCredential = await WebSignIn(context).executeSignIn();
      if (userCredential != null) {
        print('successfully signed in');
        refreshDataAndLoadApp();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(value: this, child: _WelcomePageStateView());
  }
}

class _WelcomePageStateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WelcomePageState state = context.watch();
    double columnBreakPt = PageBreaks.TabletLandscape - 100;
    state.twoColumnMode = MediaQuery.of(context).size.width > columnBreakPt;
    // Calculate how wide we want the panel, add some extra width as it grows
    double contentWidth = state.twoColumnMode ? 300 : double.infinity;
    if (state.twoColumnMode) {
      // For every 100px > the PageBreak add some panel width. Cap at some max width.
      double maxWidth = 700;
      contentWidth += min(maxWidth, MediaQuery.of(context).size.width * .15);
    }
    bool skipBirdTransition = false;
    if (state.prevSize != MediaQuery.of(context).size)
      skipBirdTransition = true;
    state.prevSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: TweenAnimationBuilder<double>(
          duration: Durations.slow,
          tween: Tween(begin: 0, end: 1),
          builder: (_, value, ___) => Opacity(
            opacity: value,
            child: Center(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: AnimatedBirdSplashWidget(
                      showText: state.isLoading,
                    ),
                  )
                      .opacity(1.0)
                      .padding(
                          right: (state.showContent && state.twoColumnMode
                              ? contentWidth
                              : 0),
                          animate: true)
                      .animate(
                        skipBirdTransition ? 0.seconds : Durations.slow,
                        Curves.easeOut,
                      ),
                  _WelcomeContentStack()
                      .width(contentWidth)
                      // Use an AnimatedPanel to slide the panel open/closed
                      .animatedPanelX(
                        isClosed: !state.showContent,
                        closeX: MediaQuery.of(context).size.width,
                        curve: Curves.easeOut,
                        duration: Durations.slow.inMilliseconds * .001,
                      )
                      // Pin the left side on fullscreen, respect existing width otherwise
                      .positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: state.twoColumnMode ? null : 0)
                ],
              ),
            ),
          ),
        ));
  }
}

class _WelcomeContentStack extends StatelessWidget {
  const _WelcomeContentStack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomePageState state = context.watch();
    //Bg shape is rounded on the left corners when in dual-column mode, but square in full-screen
    BorderRadius getBgShape() => state.twoColumnMode
        ? BorderRadius.only(
            topLeft: Radius.circular(Corners.s10),
            bottomLeft: Radius.circular(Corners.s10))
        : null;

    AppTheme theme = context.watch();
    return state.isLoading
        ? StyledProgressSpinner().backgroundColor(theme.accent1)
        : Stack(
            children: [
              FadingIndexedStack(
                duration: Durations.slow,
                index: state.pageIndex,
                children: <Widget>[
                  WelcomePageStep1(singleColumnMode: !state.twoColumnMode)
                      .scrollable()
                      .center()
                ],
              ).padding(vertical: Insets.l * 1.5).center(),
            ],
          )
            .padding(horizontal: Insets.l)
            .decorated(color: theme.accent1, borderRadius: getBgShape())
            .alignment(Alignment.center)
            .width(double.infinity);
  }
}
