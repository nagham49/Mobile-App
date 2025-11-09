import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool animateContent;
  final Duration animationDuration;

  const BaseLayout({
    super.key,
    required this.child,
    this.padding,
    this.animateContent = false,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.12, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.animateContent) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BaseLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animateContent && !oldWidget.animateContent) {
      _controller.forward(from: 0);
    } else if (!widget.animateContent && oldWidget.animateContent) {
      _controller.value = 1.0;
    } else if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
      if (widget.animateContent) {
        _controller.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Whitelogo.png',
          width: 300,
          height: 100,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
        widget.child,
      ],
    );

    if (widget.animateContent) {
      content = FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(scale: _scaleAnimation, child: content),
        ),
      );
    }

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
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      widget.padding ??
                      const EdgeInsets.symmetric(horizontal: 32.0),
                  child: content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
