import 'package:flutter/material.dart';
import 'package:flutterfolio/presentation/widgets/animated_positioned_text.dart';
import 'package:flutterfolio/presentation/widgets/animated_text_slide_box_transition.dart';
import 'package:flutterfolio/presentation/widgets/spaces.dart';
import 'package:flutterfolio/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';

const double spacing = 20;

class TechnologySection extends StatelessWidget {
  const TechnologySection({
    super.key,
    required this.controller,
    required this.width,
  });

  final AnimationController controller;

  final double width;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.titleMedium?.copyWith(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.black,
    );
    return SizedBox(
      width: width,
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;

          if (screenWidth < const RefinedBreakpoints().tabletNormal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextSlideBoxTransition(
                  controller: controller,
                  width: screenWidth,
                  text: StringConst.MOBILE_TECH,
                  textStyle: titleStyle,
                ),
                const SpaceH20(),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 20,
                  children: _buildTechnologies(
                    context,
                    data: Data.mobileTechnologies,
                    controller: controller,
                    width: screenWidth,
                  ),
                ),
                const SpaceH40(),
                AnimatedTextSlideBoxTransition(
                  controller: controller,
                  width: screenWidth,
                  text: StringConst.OTHER_TECH,
                  textStyle: titleStyle,
                ),
                const SpaceH20(),
                Wrap(
                  spacing: (width * 0.1) / 3,
                  runSpacing: 20,
                  children: _buildTechnologies(
                    context,
                    controller: controller,
                    data: Data.otherTechnologies,
                    width: width * 0.3,
                  ),
                ),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextSlideBoxTransition(
                        controller: controller,
                        width: width * 0.25,
                        text: StringConst.MOBILE_TECH,
                        textStyle: titleStyle,
                      ),
                      const SpaceH20(),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: spacing,
                        children: _buildTechnologies(
                          context,
                          controller: controller,
                          data: Data.mobileTechnologies,
                          width: width * 0.25,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: (width * 0.75),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextSlideBoxTransition(
                          controller: controller,
                          width: (width * 0.75),
                          text: StringConst.OTHER_TECH,
                          textStyle: titleStyle,
                        ),
                        const SpaceH20(),
                        Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: _buildTechnologies(
                            context,
                            controller: controller,
                            data: Data.otherTechnologies,
                            width: ((width * 0.75) - (spacing * 3)) / 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildTechnologies(
    BuildContext context, {
    required List<String> data,
    required AnimationController controller,
    double? width,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? bodyText1Style = textTheme.bodyLarge?.copyWith(
      fontSize: Sizes.TEXT_SIZE_15,
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
    );
    List<Widget> items = [];
    for (var item in data) {
      items.add(
        SizedBox(
          width: width,
          child: AnimatedPositionedText(
            controller: CurvedAnimation(
              parent: controller,
              curve: const Interval(
                0.6,
                1.0,
                curve: Curves.ease,
              ),
            ),
            text: item,
            textStyle: bodyText1Style,
          ),
        ),
      );
    }

    return items;
  }
}
