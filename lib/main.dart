import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '_internal/components/no_glow_scroll_behavior.dart';
import 'globals.dart';
import 'models/app_model.dart';
import 'models/authentication_model.dart';
import 'styles.dart';
import 'themes.dart';
import 'package:electricbuy/app_extensions.dart';
import 'views/welcome/welcome_page.dart';

void main() {
  // FirebaseService firebase = FirebaseFactory.create();
  var appModel = AppModel();

  runApp(MultiProvider(
    providers: [
      // Firebase
      // Provider.value(value: firebase),

      ChangeNotifierProvider.value(value: appModel),
      ChangeNotifierProvider(create: (c) => AuthModel()),

      // Provider(create: (_) => GoogleRestService()),
      Provider<BuildContext>(create: (c) => c),
    ],
    //child: BasicRouterSpike(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<WelcomePageState> _welcomePageKey = GlobalKey();
  // CheckConnectionCommand _connectionChecker;
  // PollSocialCommand _pollSocialCommand;
  bool _settingsLoaded = false;

  @override
  void initState() {
    context.read<AppModel>().load().then((value) async {
      WelcomePageState welcomePage = _welcomePageKey.currentState;
      await Firebase.initializeApp();
      // if (isSignedIn == true) {
      //   // Login into the main app
      //   welcomePage.refreshDataAndLoadApp();
      // } else {
      // Show login panel so user can sign-in
      welcomePage.showPanel(true);
      // }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeType themeType =
        context.select<AppModel, ThemeType>((value) => value.theme);
    AppTheme theme = AppTheme.fromType(themeType);

    /// Disable shadows on web builds for better performance
    if (UniversalPlatform.isWeb) {
      Shadows.enabled = false;
    }

    return Provider.value(
      value: theme, // Provide the current theme to the entire app
      child: MaterialApp(
        title: "Buy Electricity",
        debugShowCheckedModeBanner: false,
        navigatorKey: AppGlobals.rootNavKey,

        /// Pass active theme into MaterialApp
        theme: theme.themeData,

        /// Home defaults to SplashView, BootstrapCommand will load the initial page
        home: WelcomePage(key: _welcomePageKey),

        /// Wrap root navigator in various styling widgets
        builder: (_, navigator) {
          // Wrap root page in a builder, so we can make initial responsive tweaks based on MediaQuery
          return Builder(builder: (c) {
            //Responsive: Reduce size of our gutter scale when we're below a certain size
            Insets.gutterScale = c.widthPx < PageBreaks.TabletPortrait ? .5 : 1;
            // Disable all Material glow effects with [ NoGlowScrollBehavior ]
            return ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: navigator,
            );
          });
        },
      ),
    );
  }
}
