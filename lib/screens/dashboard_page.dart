import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/date_filter_selector.dart';
import '../widgets/section_header.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/value_donut_chart.dart';
import '../widgets/value_sales_growth_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.selectedCategory,
    required this.selectedStore,
    this.storeOptions = const [],
  });

  final String selectedCategory;
  final String selectedStore;
  final List<String> storeOptions;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String _currentStore;
  late List<String> _storeOptions;
  final PageController _chartController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    _currentStore = widget.selectedStore;
    _storeOptions = {...widget.storeOptions, _currentStore}.toList()..sort();
  }

  @override
  void didUpdateWidget(covariant DashboardPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.storeOptions != widget.storeOptions ||
        oldWidget.selectedStore != widget.selectedStore) {
      _storeOptions = {...widget.storeOptions, _currentStore}.toList()..sort();
    }
  }

  @override
  void dispose() {
    _chartController.dispose();
    super.dispose();
  }

  void _handleStoreChanged(String? newStore) {
    if (newStore == null) return;
    setState(() {
      _currentStore = newStore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final segments = [
      DonutChartSegment(
        label: 'Market',
        value: 28.0,
        color: AppColors.primaryMain,
      ),
      DonutChartSegment(
        label: 'Savola',
        value: 72.0,
        color: AppColors.primarySecond,
      ),
    ];

    final chartItems = [
      ValueDonutChart(
        title: 'Value Share',
        segments: segments,
        legendTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryMain,
          fontWeight: FontWeight.w600,
        ),
      ),
      const ValueSalesGrowthChart(
        title: 'Price Index Change',
        data: [
          SalesGrowthData(
            label: 'Savola',
            value: 51.87,
            color: AppColors.primarySecond,
          ),
          SalesGrowthData(
            label: 'Market',
            value: 15.84,
            color: AppColors.primaryMain,
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: TopAppBar(
        pageTitle: 'Dashboard',
        selectedStore: _currentStore,
        storeOptions: _storeOptions,
        onStoreChanged: _handleStoreChanged,
        onMenuPressed: () {},
        onLanguagePressed: () {},
        onNotificationsPressed: () {},
        onProfilePressed: () {},
      ),
      backgroundColor: AppColors.secondaryMain,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Market KPIs'),
            const SizedBox(height: 12),
            Center(
              child: DateFilterSelector(
                filters: const ['Past 4 Weeks', 'Past 3 Months', 'MAT24'],
                onChanged: (value) {
                  // TODO: update dashboard metrics based on selection
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _chartController,
                itemCount: chartItems.length,
                padEnds: true,
                itemBuilder: (context, index) {
                  return _ChartCard(child: chartItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 64;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            spreadRadius: -4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }
}
