import 'package:flutter/material.dart';

// A styled, tappable card. Takes a colour, an optional child, and an
// optional onPress callback — used for every card on both screens.
class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.colour,
    this.cardChild,
    this.onPress,
  });

  final Color colour;
  final Widget? cardChild;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}
