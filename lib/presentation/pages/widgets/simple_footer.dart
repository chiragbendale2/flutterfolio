import 'package:flutter/material.dart';
import 'package:flutterfolio/core/layout/adaptive.dart';
import 'package:flutterfolio/core/utils/functions.dart';
import 'package:flutterfolio/presentation/pages/widgets/socials.dart';
import 'package:flutterfolio/presentation/widgets/animated_line_through_text.dart';
import 'package:flutterfolio/presentation/widgets/spaces.dart';
import 'package:flutterfolio/values/values.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SimpleFooter extends StatelessWidget {
  const SimpleFooter({
    super.key,
    this.height,
    this.width,
    this.backgroundColor = AppColors.black,
  });

  final double? width;
  final double? height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? widthOfScreen(context),
      height: height ?? assignHeight(context, 0.2),
      color: backgroundColor,
      child: Center(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isMobile) {
              return const Column(
                children: [
                  Spacer(flex: 2),
                  SimpleFooterSm(),
                  Spacer(),
                ],
              );
            } else {
              return const Column(
                children: [
                  Spacer(),
                  SimpleFooterLg(),
                  SpaceH20(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class SimpleFooterSm extends StatelessWidget {
  const SimpleFooterSm({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyLarge?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Column(
      children: [
        Socials(socialData: Data.socialData),
        const SpaceH30(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringConst.COPYRIGHT,
              style: style,
            ),
          ],
        ),
        const SpaceH12(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Functions.launchUrlString(StringConst.DESIGN_LINK);
              },
              child: AnimatedLineThroughText(
                text: StringConst.DESIGNED_BY,
                isUnderlinedByDefault: true,
                isUnderlinedOnHover: false,
                hoverColor: AppColors.white,
                coverColor: AppColors.black,
                textStyle: style?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SpaceH8(),
        const BuiltWithFlutter(),
      ],
    );
  }
}

class SimpleFooterLg extends StatelessWidget {
  const SimpleFooterLg({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyLarge?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Socials(socialData: Data.socialData),
          ],
        ),
        const SpaceH20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringConst.COPYRIGHT,
              style: style,
            ),
            const SpaceW8(),
            InkWell(
              onTap: () {
                Functions.launchUrlString(StringConst.DESIGN_LINK);
              },
              child: AnimatedLineThroughText(
                text: StringConst.DESIGNED_BY,
                isUnderlinedByDefault: true,
                isUnderlinedOnHover: false,
                hoverColor: AppColors.white,
                coverColor: AppColors.black,
                textStyle: style?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SpaceH8(),
        const BuiltWithFlutter(),
      ],
    );
  }
}

class BuiltWithFlutter extends StatelessWidget {
  const BuiltWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyLarge?.copyWith(
      color: AppColors.accentColor,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          StringConst.BUILT_WITH_FLUTTER,
          style: style,
        ),
        const FlutterLogo(size: 14),
        Text(
          " with ",
          style: style,
        ),
        const Icon(
          FontAwesomeIcons.solidHeart,
          size: 14,
          color: AppColors.errorRed,
        )
      ],
    );
  }
}
