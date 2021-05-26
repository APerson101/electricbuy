import 'package:electricbuy/Commands/history/refreshhistory.dart';
import 'package:electricbuy/_internal/components/simple_value_notifier.dart';
import 'package:electricbuy/_internal/utils/utils.dart';
import 'package:electricbuy/models/app_model.dart';
import 'package:electricbuy/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mainscaffoldview.dart';

enum PageType { None, Dashboard, History }

class MainScaffold extends StatefulWidget {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  MainScaffoldState createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  List<PageType> pages = [
    PageType.Dashboard,
    PageType.History,
  ];
  SimpleValueNotifier<List<HistoryData>> checkedContactsNotifier =
      SimpleValueNotifier([]);
  AppModel appModel;
  @override
  void initState() {
    /// Get a reference to the app model
    appModel = context.read();

    /// Change current page
    Future.microtask(() => trySetCurrentPage(PageType.Dashboard, false));
    super.initState();
  }

  /// Disable scaffold animations, used when changing pages, so the new page does not animate in
  bool skipScaffoldAnims = false;

  /// Attempt to change current page, this might not complete if user is currently editing
  Future<void> trySetCurrentPage(PageType t, [bool refresh = true]) async {
    if (t == appModel.currentMainPage) return;

    // Change page
    appModel.currentMainPage = t;

    //Refresh each time we change pages
    if (refresh) {
      RefreshHistory(context).execute();
    }
  }

  void handleBgTapped() {
    Utils.unFocus();
  }

  void openMenu() => MainScaffold.scaffoldKey.currentState.openDrawer();

  @override
  Widget build(BuildContext context) {
    print('home page main scaffold');
    return Provider.value(
      value: this,
      child: MainScaffoldView(this),
    );
  }
}
