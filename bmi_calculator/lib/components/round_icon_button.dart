import 'package:flutter/material.dart';

import '../constants.dart';

// A small round +/- button for the weight and age steppers.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: const CircleBorder(),
      fillColor: kRoundButtonColour,
      child: Icon(icon),
    );
  }
}
