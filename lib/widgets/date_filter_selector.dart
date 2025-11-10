import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DateFilterSelector extends StatefulWidget {
  const DateFilterSelector({
    super.key,
    required this.filters,
    this.initialFilter,
    this.onChanged,
  });

  final List<String> filters;
  final String? initialFilter;
  final ValueChanged<String>? onChanged;

  @override
  State<DateFilterSelector> createState() => _DateFilterSelectorState();
}

class _DateFilterSelectorState extends State<DateFilterSelector> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialFilter ?? widget.filters.first;
  }

  void _handleTap(String filter) {
    if (_selected == filter) return;
    setState(() => _selected = filter);
    widget.onChanged?.call(filter);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 0),
        itemBuilder: (context, index) {
          final filter = widget.filters[index];
          final isSelected = filter == _selected;

          return GestureDetector(
            onTap: () => _handleTap(filter),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryMain : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppColors.secondaryMain
                      : AppColors.primaryMain,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
