import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'legend_item.dart';

class SalesGrowthData {
  const SalesGrowthData({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;
}

class ValueSalesGrowthChart extends StatelessWidget {
  const ValueSalesGrowthChart({
    super.key,
    required this.title,
    required this.data,
    this.legendTextStyle,
  });

  final String title;
  final List<SalesGrowthData> data;
  final TextStyle? legendTextStyle;

  double _maxValue() {
    if (data.isEmpty) return 0;
    return data.map((e) => e.value.abs()).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = _maxValue();
    final theme = Theme.of(context);
    final effectiveLegendStyle =
        legendTextStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryMain,
          fontWeight: FontWeight.w600,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryMain,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: data.map((entry) {
            final heightFactor = maxValue == 0
                ? 0.0
                : (entry.value.abs() / (maxValue * 1.05));
            final barHeight = (160 * heightFactor).clamp(0, 160).toDouble();
            final valueText = entry.value.toStringAsFixed(2);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 160,
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    width: 56,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: entry.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      valueText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryMain,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: data
              .map(
                (entry) => LegendItem(
                  color: entry.color,
                  label: entry.label,
                  textStyle: effectiveLegendStyle,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
