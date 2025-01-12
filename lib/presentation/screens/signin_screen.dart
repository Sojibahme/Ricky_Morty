
import 'package:flutter/material.dart';
import 'package:ricky_morty/presentation/screens/navigation_screen.dart';
import 'package:ricky_morty/services/auth_service.dart';
import 'package:ricky_morty/utils/colors.dart';

class SignInScreen extends StatelessWidget {
  final AuthService authService;

  const SignInScreen({Key? key, required this.authService}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.RNMBlack,
              AppColors.RNMBlue,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/rick-and-morty.png',
                height: 200,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.RNMGreen.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  try {
                    final account = await authService.signInWithGoogle();
                    if (account != null && context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationScreen(),
                        ),
                      );
                    }
                  } catch (e) {
                    debugPrint('Sign-in failed: $e');
                  }
                },

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.g_mobiledata,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}