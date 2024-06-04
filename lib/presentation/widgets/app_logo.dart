import 'package:flutter/material.dart';
import 'package:flutterfolio/values/values.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.title = "CB",
    this.titleColor = AppColors.black,
    this.titleStyle,
    this.fontSize = 60,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: titleStyle ??
          textTheme.displayMedium?.copyWith(
            color: titleColor,
            fontSize: fontSize,
          ),
    );
  }
}
