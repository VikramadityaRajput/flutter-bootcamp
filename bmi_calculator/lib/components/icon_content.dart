import 'package:flutter/material.dart';

import '../constants.dart';

// The inside of a gender card: a big icon above a label.
class IconContent extends StatelessWidget {
  const IconContent({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80.0),
        const SizedBox(height: 15.0),
        Text(label, style: kLabelTextStyle),
      ],
    );
  }
}
