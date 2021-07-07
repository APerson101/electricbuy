import 'package:electricbuy/_internal/components/fading_index_stack.dart';
import 'package:electricbuy/_internal/widget_view.dart';
import 'package:electricbuy/models/app_model.dart';
import 'package:electricbuy/models/history_model.dart';
import 'package:electricbuy/styled_components/electricbuy_logo.dart';
import 'package:electricbuy/styled_components/styled_container.dart';
import 'package:electricbuy/views/aboutus.dart';
import 'package:electricbuy/views/contactus.dart';
import 'package:electricbuy/views/dashboardpage/dashboardpage.dart';
import 'package:electricbuy/views/history_page/history_page.dart';
import 'package:electricbuy/views/mainscaffold/mainscaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../styles.dart';
import 'package:electricbuy/app_extensions.dart';

import '../../themes.dart';
import 'mainsidemenu.dart';

class MainScaffoldView extends WidgetView<MainScaffold, MainScaffoldState> {
  MainScaffoldView(MainScaffoldState state) : super(state);

  @override
  Widget build(BuildContext context) {
    var currentPage =
        context.select<AppModel, PageType>((value) => value.currentMainPage);

    /// /////////////////////////////////////////////////
    /// RESPONSIVE LAYOUT LOGIC

    /// Calculate Left Menu Size
    double leftMenuWidth = Sizes.sideBarSm;
    bool skinnyMenuMode = true;
    if (context.widthPx >= PageBreaks.Desktop) {
      leftMenuWidth = Sizes.sideBarLg;
      skinnyMenuMode = false;
    } else if (context.widthPx > PageBreaks.TabletLandscape) {
      leftMenuWidth = Sizes.sideBarMed;
    }

    /// Calculate Right panel size
    double detailsPanelWidth = 400;
    if (context.widthInches > 8) {
      //Panel size gets a little bigger as the screen size grows
      detailsPanelWidth += (context.widthInches - 8) * 12;
    }

    bool isNarrow = context.widthPx < PageBreaks.TabletPortrait;

    /// Calculate Top bar height
    double topBarHeight = 60;
    double topBarPadding = isNarrow ? Insets.m : Insets.l;

    /// Figure out what should be visible, and the size of our viewport
    /// 3 cases: 1) Single Column, 2) LeftMenu + Single Column,
    bool showPanel = false;
    bool showLeftMenu =
        !isNarrow; //Whether main menu is shown, or hidden behind hamburger btn
    bool useSingleColumn = context.widthInches <
        10; //Whether detail panel fills the entire content area
    bool hideContent = showPanel &&
        useSingleColumn; //If single column + panel, we can hide the content
    double leftContentOffset = showLeftMenu
        ? leftMenuWidth
        : Insets.mGutter; //Left position for the main content stack
    double contentRightPos = showPanel
        ? detailsPanelWidth
        : 0; //Right position for main content stack

    /// Sometimes we want to skip the layout animations, for example, when we're changing main pages ,
    /// we want the new page to ignore the panel that is sliding out of the view.
    Duration animDuration = state.skipScaffoldAnims ? .01.seconds : .35.seconds;
    state.skipScaffoldAnims =
        false; // Reset flag so we only skip animations for one build cycle
    if (UniversalPlatform.isWeb) {
      animDuration = .0.seconds;
    }

    /// Main content page stack
    Widget contentStack = FadingIndexedStack(
      index: state.pages.indexOf(currentPage),
      children: <Widget>[
        /// DASHBOARD PAGE
        DashboardPage().padding(
            left: leftContentOffset + Insets.mGutter, right: Insets.mGutter),

        /// HISTORY PAGE
        ValueListenableBuilder<List<HistoryData>>(
          valueListenable: state.checkedContactsNotifier,
          builder: (_, checkedContacts, __) {
            return HistoryPage()
                //Asymmetric padding for the ListView, as we need to leave room in the gutter for the scroll bar
                .padding(left: Insets.lGutter, right: Insets.mGutter);
          },
        ),
        AboutUS().padding(
            left: leftContentOffset + Insets.mGutter, right: Insets.mGutter),
        ContactUS().padding(
            left: leftContentOffset + Insets.mGutter, right: Insets.mGutter),
      ],
    );
    //contentStack = RepaintBoundary(child: contentStack);
    contentStack = FocusTraversalGroup(child: contentStack);
    AppTheme theme = context.watch();
    return Scaffold(
      drawer: showLeftMenu
          ? null
          : MainSideMenu(
              onPageSelected: state.trySetCurrentPage,
            ).constrained(maxWidth: Sizes.sideBarLg),
      body: StyledContainer(
        theme.bg1,
        child: Stack(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: topBarHeight,
                      child: Container(
                          child: Center(
                        child: Row(children: [
                          Text("Alameen or something idk"),
                          Text("16/eng02/419")
                        ]),
                        // color: Colors.green,
                      )),
                    )
                  ],
                ).positioned(height: topBarHeight + topBarPadding),
                contentStack.padding(top: topBarHeight + topBarPadding),
                IconButton(
                        icon: Icon(Icons.menu, size: 24, color: theme.accent1),
                        onPressed: state.openMenu)
                    .animatedPanelX(closeX: -50, isClosed: showLeftMenu)
                    .positioned(left: Insets.m, top: Insets.m),
                if (isNarrow)
                  ElectricbuyLogo(40, theme.accent1)
                      .alignment(Alignment.topCenter),
                // .padding(top: Insets.l),
                MainSideMenu(
                  onPageSelected: state.trySetCurrentPage,
                  skinnyMode: skinnyMenuMode,
                )
                    .animatedPanelX(
                      closeX: -leftMenuWidth,
                      // Rely on the animatedPanel to toggle visibility of this when it's hidden. It renders an empty Container() when closed
                      isClosed: !showLeftMenu,
                    ) // Styling, pin to left, fixed width
                    .positioned(
                        left: 0,
                        top: 0,
                        width: leftMenuWidth,
                        bottom: 0,
                        animate: true)
                    .animate(animDuration, Curves.easeOut),
              ],
            )
          ],
        ),
      ),
    ).gestures(onTap: state.handleBgTapped);
  }
}
