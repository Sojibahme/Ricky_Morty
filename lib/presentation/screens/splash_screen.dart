import 'package:flutter/material.dart';
import 'package:ricky_morty/utils/colors.dart';
import 'navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainNavigationScreen();
  }

  void _navigateToMainNavigationScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash-screen-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered logo
          Center(
            child: Image.asset('assets/images/rick-and-morty.png'),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.RNMBlack),
                SizedBox(height: 16),
                Text(
                  'Loading',
                  style: TextStyle(
                    color: AppColors.RNMBlack,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
