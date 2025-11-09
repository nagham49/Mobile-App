import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TransitionScreen extends StatefulWidget {
  final Widget nextPage;
  final Duration duration;
  final Color backgroundColor;
  final String logoAsset;

  const TransitionScreen({
    super.key,
    required this.nextPage,
    this.duration = const Duration(milliseconds: 500),
    this.backgroundColor = AppColors.primaryMain,
    this.logoAsset = 'assets/images/Whitelogo.png',
  });

  @override
  State<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  @override
  void initState() {
    super.initState();
    _goToNextPage();
  }

  Future<void> _goToNextPage() async {
    await Future.delayed(widget.duration);
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => widget.nextPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(widget.logoAsset, width: 300, fit: BoxFit.contain),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.secondaryMain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
