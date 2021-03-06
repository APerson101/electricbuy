import 'package:electricbuy/app_extensions.dart';
import 'package:electricbuy/styles.dart';
import 'package:electricbuy/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ClickableText extends StatelessWidget {
  final Function(String) onPressed;
  final String text;
  final TextStyle style;
  final Color linkColor;
  final bool underline;

  const ClickableText(this.text,
      {Key key,
      this.onPressed,
      this.style,
      this.underline = false,
      this.linkColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    var ts = (style ?? TextStyles.Body1.textHeight(1.5));
    Widget t = Text(
      text ?? "",
      style: style ?? (underline ? ts.underline : ts),
      overflow: TextOverflow.clip,
    );
    if (onPressed != null) {
      /// Add tap handlers and style text
      t = (t as Text).textColor(linkColor ?? theme.accent1).clickable(
            () => onPressed?.call(text),
          );
    }
    return t.translate(offset: Offset(0, 0));
  }
}
