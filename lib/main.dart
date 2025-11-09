import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MarketeersApp());
}

class MarketeersApp extends StatefulWidget {
  const MarketeersApp({super.key});

  @override
  State<MarketeersApp> createState() => _MarketeersAppState();
}

class _MarketeersAppState extends State<MarketeersApp> {
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _bootstrapApp();
  }

  Future<void> _bootstrapApp() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketeers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _isReady ? const LoginPage() : const SplashScreen(),
    );
  }
}
