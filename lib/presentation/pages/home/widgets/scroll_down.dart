import 'package:flutter/material.dart';
import 'package:flutterfolio/presentation/widgets/spaces.dart';
import 'package:flutterfolio/values/values.dart';

class ScrollDownButton extends StatelessWidget {
  const ScrollDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            StringConst.SCROLL_DOWN.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 1.7,
                ),
          ),
        ),
        const SpaceH16(),
        Image.asset(
          ImagePath.ARROW_DOWN,
          height: 24,
        ),
      ],
    );
  }
}
