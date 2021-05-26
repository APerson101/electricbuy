import 'package:electricbuy/_internal/components/spacing.dart';
import 'package:electricbuy/strings.dart';
import 'package:electricbuy/styled_components/buttons/primary_btn.dart';
import 'package:electricbuy/styled_components/buttons/secondary_btn.dart';
import 'package:electricbuy/styles.dart';
import 'package:flutter/material.dart';

class OkCancelBtnRow extends StatelessWidget {
  final Function() onOkPressed;
  final Function() onCancelPressed;
  final String okLabel;
  final String cancelLabel;
  final double minHeight;

  const OkCancelBtnRow(
      {Key key,
      this.onOkPressed,
      this.onCancelPressed,
      this.okLabel,
      this.cancelLabel,
      this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (onOkPressed != null)
          PrimaryTextBtn(okLabel ?? S.BTN_OK.toUpperCase(),
              onPressed: onOkPressed),
        HSpace(Insets.m),
        if (onCancelPressed != null)
          SecondaryTextBtn(cancelLabel ?? S.BTN_CANCEL.toUpperCase(),
              onPressed: onCancelPressed),
      ],
    );
  }
}
