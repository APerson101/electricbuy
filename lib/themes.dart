import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '_internal/utils/color_utils.dart';
import 'styled_components/styled_text_input.dart';

enum ThemeType {
  FlockGreen,
  FlockGreen_Dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.FlockGreen;

  bool isDark;
  Color bg1 = Color(0xfff1f7f0);
  Color surface = Colors.white; //
  Color bg2 = Color(0xffc1dcbc);
  Color accent1 = Color(0xff00a086);
  Color accent1Dark = Color(0xff00856f);
  Color accent1Darker = Color(0xff006b5a);
  Color accent2 = Color(0xfff09433);
  Color accent3 = Color(0xff5bc91a);
  Color grey = Color(0xff909f9c);
  Color greyStrong = Color(0xff151918);
  Color greyWeak = Color(0xff909f9c);
  Color error = Colors.red.shade900;
  Color focus = Color(0xFF0ee2b1);

  Color txt = Colors.black;
  Color accentTxt = Colors.white;

  AppTheme({@required this.isDark}) {
    txt = isDark ? Colors.white : Colors.black;
    Color color = isDark ? Colors.black : Colors.white;
    accentTxt = accentTxt ?? color;
  }

  factory AppTheme.fromType(ThemeType t) {
    Color c(String value) => ColorUtils.parseHex(value);
    switch (t) {
      case ThemeType.FlockGreen:
        return AppTheme(isDark: false)
          ..bg1 = Color(0xfff1f7f0)
          ..bg2 = Color(0xffc1dcbc)
          ..surface = Colors.white
          ..accent1 = Color(0xff00a086)
          ..accent1Dark = Color(0xff00856f)
          ..accent1Darker = Color(0xff006b5a)
          ..accent2 = Color(0xfff09433)
          ..accent3 = Color(0xff5bc91a)
          ..greyWeak = Color(0xff909f9c)
          ..grey = Color(0xff515d5a)
          ..greyStrong = Color(0xff151918)
          ..error = Colors.red.shade900
          ..focus = Color(0xFF0ee2b1);

      case ThemeType.FlockGreen_Dark:
        return AppTheme(isDark: true)
          ..bg1 = Color(0xff121212)
          ..bg2 = Color(0xff2c2c2c)
          ..surface = Color(0xff252525)
          ..accent1 = Color(0xff00a086)
          ..accent1Dark = Color(0xff00caa5)
          ..accent1Darker = Color(0xff00caa5)
          ..accent2 = Color(0xfff19e46)
          ..accent3 = Color(0xff5BC91A)
          ..greyWeak = Color(0xffa8b3b0)
          ..grey = Color(0xffced4d3)
          ..greyStrong = Color(0xffffffff)
          ..error = Color(0xffe55642)
          ..focus = Color(0xff0ee2b1);
      default:
        return AppTheme.fromType(defaultTheme);
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryVariant: accent1Darker,
          secondary: accent2,
          secondaryVariant: ColorUtils.shiftHsl(accent2, -.2),
          background: bg1,
          surface: surface,
          onBackground: txt,
          onSurface: txt,
          onError: txt,
          onPrimary: accentTxt,
          onSecondary: accentTxt,
          error: error ?? Colors.red.shade400),
    );
    return t.copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: ThinUnderlineBorder(),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionColor: greyWeak,
        textSelectionHandleColor: Colors.transparent,
        buttonColor: accent1,
        cursorColor: accent1,
        highlightColor: accent1,
        toggleableActiveColor: accent1);
  }

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}
