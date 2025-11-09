import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const BaseLayout({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.primaryMain),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              right: -10,
              child: Image.asset(
                'assets/images/TopVector.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              left: -10,
              child: Image.asset(
                'assets/images/BottomVector.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            // Main content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      padding ?? const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Whitelogo.png',
                        width: 300,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 30),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
