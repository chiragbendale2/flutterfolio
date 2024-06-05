import 'package:flutter/material.dart';
import 'package:flutterfolio/core/layout/adaptive.dart';
import 'package:flutterfolio/core/utils/functions.dart';
import 'package:flutterfolio/presentation/widgets/animated_bubble_button.dart';
import 'package:flutterfolio/presentation/widgets/animated_positioned_text.dart';
import 'package:flutterfolio/presentation/widgets/animated_positioned_widget.dart';
import 'package:flutterfolio/presentation/widgets/animated_text_slide_box_transition.dart';
import 'package:flutterfolio/presentation/widgets/empty.dart';
import 'package:flutterfolio/presentation/widgets/project_item.dart';
import 'package:flutterfolio/presentation/widgets/spaces.dart';
import 'package:flutterfolio/values/values.dart';

List<String> titles = [
  StringConst.PLATFORM,
  StringConst.CATEGORY,
  StringConst.AUTHOR,
  StringConst.DESIGNER,
  StringConst.TECHNOLOGY_USED,
];

class Aboutproject extends StatefulWidget {
  const Aboutproject({
    super.key,
    required this.controller,
    required this.projectDataController,
    required this.projectData,
    required this.width,
  });

  final AnimationController controller;
  final AnimationController projectDataController;
  final ProjectItemData projectData;
  final double width;

  @override
  _AboutprojectState createState() => _AboutprojectState();
}

class _AboutprojectState extends State<Aboutproject> {
  @override
  void initState() {
    super.initState();

    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.projectDataController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double googlePlayButtonWidth = 150;
    double appleStoreButtonWidth = 150;
    double targetWidth = responsiveSize(context, 118, 150, md: 150);
    double initialWidth = responsiveSize(context, 36, 50, md: 50);
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? bodyTextStyle = textTheme.bodyLarge?.copyWith(
      fontSize: Sizes.TEXT_SIZE_18,
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
      height: 2.0,
    );
    double projectDataWidth = responsiveSize(
      context,
      widget.width,
      widget.width * 0.55,
      md: widget.width * 0.75,
    );
    double projectDataSpacing = responsiveSize(context, widget.width * 0.1, 48, md: 36);
    double widthOfProjectItem = (projectDataWidth - (projectDataSpacing)) / 2;
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(100.0),
    );
    TextStyle? buttonStyle = textTheme.bodyLarge?.copyWith(
      color: AppColors.black,
      fontSize: responsiveSize(
        context,
        Sizes.TEXT_SIZE_14,
        Sizes.TEXT_SIZE_16,
        sm: Sizes.TEXT_SIZE_15,
      ),
      fontWeight: FontWeight.w500,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextSlideBoxTransition(
          controller: widget.controller,
          text: StringConst.ABOUT_PROJECT,
          coverColor: AppColors.white,
          textStyle: textTheme.headlineMedium?.copyWith(
            fontSize: Sizes.TEXT_SIZE_48,
          ),
        ),
        const SpaceH40(),
        AnimatedPositionedText(
          controller: CurvedAnimation(
            parent: widget.controller,
            curve: Animations.textSlideInCurve,
          ),
          width: widget.width * 0.7,
          maxLines: 10,
          text: widget.projectData.portfolioDescription,
          textStyle: bodyTextStyle,
        ),
        // SpaceH12(),
        SizedBox(
          width: projectDataWidth,
          child: Wrap(
            spacing: projectDataSpacing,
            runSpacing: responsiveSize(context, 30, 40),
            children: [
              ProjectData(
                controller: widget.projectDataController,
                width: widthOfProjectItem,
                title: StringConst.PLATFORM,
                subtitle: widget.projectData.platform,
              ),
              ProjectData(
                controller: widget.projectDataController,
                width: widthOfProjectItem,
                title: StringConst.CATEGORY,
                subtitle: widget.projectData.category,
              ),
              ProjectData(
                controller: widget.projectDataController,
                width: widthOfProjectItem,
                title: StringConst.AUTHOR,
                subtitle: StringConst.DEV_NAME,
              ),
            ],
          ),
        ),
        widget.projectData.designer != null ? const SpaceH30() : const Empty(),
        widget.projectData.designer != null
            ? ProjectData(
                controller: widget.projectDataController,
                title: StringConst.DESIGNER,
                subtitle: widget.projectData.designer!,
              )
            : const Empty(),
        widget.projectData.technologyUsed != null ? const SpaceH30() : const Empty(),
        widget.projectData.technologyUsed != null
            ? ProjectData(
                controller: widget.projectDataController,
                title: StringConst.TECHNOLOGY_USED,
                subtitle: widget.projectData.technologyUsed!,
              )
            : const Empty(),
        const SpaceH30(),
        Row(
          children: [
            widget.projectData.isLive
                ? AnimatedPositionedWidget(
                    controller: CurvedAnimation(
                      parent: widget.projectDataController,
                      curve: Animations.textSlideInCurve,
                    ),
                    width: targetWidth,
                    height: initialWidth,
                    child: AnimatedBubbleButton(
                      title: StringConst.LAUNCH_APP,
                      color: AppColors.grey100,
                      imageColor: AppColors.black,
                      startBorderRadius: borderRadius,
                      startWidth: initialWidth,
                      height: initialWidth,
                      targetWidth: targetWidth,
                      titleStyle: buttonStyle,
                      onTap: () {
                        Functions.launchUrlString(widget.projectData.webUrl);
                      },
                      startOffset: const Offset(0, 0),
                      targetOffset: const Offset(0.1, 0),
                    ),
                  )
                : const Empty(),
            widget.projectData.isLive ? const Spacer() : const Empty(),
            widget.projectData.isPublic
                ? AnimatedPositionedWidget(
                    controller: CurvedAnimation(
                      parent: widget.projectDataController,
                      curve: Animations.textSlideInCurve,
                    ),
                    width: targetWidth,
                    height: initialWidth,
                    child: AnimatedBubbleButton(
                      title: StringConst.SOURCE_CODE,
                      color: AppColors.grey100,
                      imageColor: AppColors.black,
                      startBorderRadius: borderRadius,
                      startWidth: initialWidth,
                      height: initialWidth,
                      targetWidth: targetWidth,
                      titleStyle: buttonStyle,
                      startOffset: const Offset(0, 0),
                      targetOffset: const Offset(0.1, 0),
                      onTap: () {
                        Functions.launchUrlString(widget.projectData.gitHubUrl);
                      },
                    ),
                  )
                : const Empty(),
            widget.projectData.isPublic ? const Spacer() : const Empty(),
          ],
        ),
        widget.projectData.isPublic || widget.projectData.isLive ? const SpaceH30() : const Empty(),
        widget.projectData.isOnPlayStore
            ? InkWell(
                onTap: () {
                  Functions.launchUrlString(widget.projectData.playStoreUrl);
                },
                child: AnimatedPositionedWidget(
                  controller: CurvedAnimation(
                    parent: widget.projectDataController,
                    curve: Animations.textSlideInCurve,
                  ),
                  width: googlePlayButtonWidth,
                  height: 50,
                  child: Image.asset(
                    ImagePath.GOOGLE_PLAY,
                    width: googlePlayButtonWidth,
                    // fit: BoxFit.fitHeight,
                  ),
                ),
              )
            : const Empty(),
        widget.projectData.isOnAppStore
            ? InkWell(
                onTap: () {
                  Functions.launchUrlString(widget.projectData.appStoreUrl);
                },
                child: AnimatedPositionedWidget(
                  controller: CurvedAnimation(
                    parent: widget.projectDataController,
                    curve: Animations.textSlideInCurve,
                  ),
                  width: appleStoreButtonWidth,
                  height: 50,
                  child: Image.asset(
                    ImagePath.APP_STORE,
                    width: appleStoreButtonWidth,
                    // fit: BoxFit.fitHeight,
                  ),
                ),
              )
            : const Empty(),
      ],
    );
  }
}

class ProjectData extends StatelessWidget {
  const ProjectData({
    super.key,
    required this.title,
    required this.subtitle,
    required this.controller,
    this.width = double.infinity,
    this.titleStyle,
    this.subtitleStyle,
  });

  final String title;
  final String subtitle;
  final double width;
  final AnimationController controller;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    TextStyle? defaultTitleStyle = textTheme.titleMedium?.copyWith(
      color: AppColors.black,
      fontSize: 17,
    );
    TextStyle? defaultSubtitleStyle = textTheme.bodyLarge?.copyWith(
      fontSize: 15,
    );

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTextSlideBoxTransition(
            width: width,
            maxLines: 2,
            coverColor: AppColors.white,
            controller: controller,
            text: title,
            textStyle: titleStyle ?? defaultTitleStyle,
          ),
          const SpaceH12(),
          AnimatedPositionedText(
            width: width,
            maxLines: 2,
            controller: CurvedAnimation(
              parent: controller,
              curve: Animations.textSlideInCurve,
            ),
            text: subtitle,
            textStyle: subtitleStyle ?? defaultSubtitleStyle,
          ),
        ],
      ),
    );
  }
}
