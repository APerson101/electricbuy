import 'package:electricbuy/views/mainscaffold/mainscaffold.dart';

import '../themes.dart';
import 'abstract_model.dart';

class AppModel extends AbstractModel {
  ThemeType get theme => _theme;
  ThemeType _theme = ThemeType.FlockGreen;
  String version = "0.0.0";

  load() async {}

  /// //////////////////////////////////////////////////
  /// Holds current page type, synchronizes leftMenu with the mainContent
  PageType get currentMainPage => _currentMainPage;
  PageType _currentMainPage;

  set currentMainPage(PageType value) {
    _currentMainPage = value;
    notifyListeners();
  }

  set theme(ThemeType value) {
    _theme = value;
    notifyListeners();
  }

  void nextTheme() {
    theme = (theme == ThemeType.FlockGreen_Dark)
        ? ThemeType.FlockGreen
        : ThemeType.FlockGreen_Dark;
  }
}
