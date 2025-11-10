import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'legend_item.dart';

class DonutChartSegment {
  const DonutChartSegment({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;
}

class ValueDonutChart extends StatelessWidget {
  const ValueDonutChart({
    super.key,
    required this.title,
    required this.segments,
    this.centerLabel,
    this.centerLabelStyle,
    this.titleStyle,
    this.legendTextStyle,
    this.chartHeight = 120,
    this.centerSpaceRadius = 32,
  }) : assert(
         segments.length >= 2,
         'Provide at least two segments for the chart',
       );

  final String title;
  final List<DonutChartSegment> segments;
  final String? centerLabel;
  final TextStyle? centerLabelStyle;
  final TextStyle? titleStyle;
  final TextStyle? legendTextStyle;
  final double chartHeight;
  final double centerSpaceRadius;

  double get _totalValue => segments.fold<double>(
    0,
    (previousValue, element) => previousValue + element.value,
  );

  @override
  Widget build(BuildContext context) {
    final effectiveTitleStyle =
        titleStyle ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        );
    final effectiveLegendStyle =
        legendTextStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: effectiveTitleStyle, textAlign: TextAlign.center),
        const SizedBox(height: 30),
        SizedBox(
          height: chartHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  startDegreeOffset: -90,
                  centerSpaceRadius: centerSpaceRadius,
                  pieTouchData: PieTouchData(enabled: false),
                  sections: segments.map((segment) {
                    final percentage = _totalValue == 0
                        ? 0
                        : (segment.value / _totalValue * 100);
                    return PieChartSectionData(
                      color: segment.color,
                      value: segment.value,
                      title: '${percentage.toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      titlePositionPercentageOffset: 0.6,
                      radius: chartHeight / 2.2,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: segments
              .map(
                (segment) => LegendItem(
                  color: segment.color,
                  label: segment.label,
                  textStyle: effectiveLegendStyle,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
