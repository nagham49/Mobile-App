import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/base_layout.dart';
import 'category_selection_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasAttemptedLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _hasAttemptedLogin = true;
    });
    // Validate after setting the flag
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CategorySelectionPage()),
      );
    } else {
      // Force validation to show errors
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      animateContent: true,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Marketeers Research',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.secondaryMain,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            // Login with Email section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: AppColors.secondaryMain.withOpacity(0.3),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'login with Email',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.secondaryMain,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: AppColors.secondaryMain.withOpacity(0.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Email input field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Your Email',
                hintStyle: TextStyle(color: AppColors.secondaryDark),
                errorStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: AppColors.secondaryMain,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (_hasAttemptedLogin && !value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Password input field
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Your Password',
                hintStyle: TextStyle(color: AppColors.secondaryDark),
                errorStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: AppColors.secondaryMain,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryMain,
                  foregroundColor: AppColors.primaryMain,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
