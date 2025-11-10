import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.lineColor = const Color(0xFFD9D9D9),
    this.textStyle,
    this.lineThickness = 1.5,
    this.spacing = 16,
  });

  final String title;
  final Color lineColor;
  final TextStyle? textStyle;
  final double lineThickness;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle =
        textStyle ??
        Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 112, 112, 112),
          letterSpacing: 0.4,
        );

    return Row(
      children: [
        Expanded(
          child: _Divider(color: lineColor, thickness: lineThickness),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: Text(title, style: effectiveStyle),
        ),
        Expanded(
          child: _Divider(color: lineColor, thickness: lineThickness),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color, required this.thickness});

  final Color color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thickness,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(thickness),
      ),
    );
  }
}
