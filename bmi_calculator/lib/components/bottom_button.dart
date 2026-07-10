import 'package:flutter/material.dart';

import '../constants.dart';

// The full-width pink bar at the bottom of each screen (CALCULATE / RE-CALCULATE).
class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });

  final String buttonTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kBottomContainerColour,
        margin: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: kBottomContainerHeight,
        child: Center(
          child: Text(buttonTitle, style: kLargeButtonTextStyle),
        ),
      ),
    );
  }
}
