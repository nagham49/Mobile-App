import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    this.textStyle,
  });

  final Color color;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: textStyle),
      ],
    );
  }
}
