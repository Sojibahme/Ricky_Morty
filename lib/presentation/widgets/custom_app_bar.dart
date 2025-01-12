import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:ricky_morty/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  final bool showBackButton;

  CustomAppBar({this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [1.0, 0.0, 0.1, 0.3, 0.5, 0.7, 0.8],
          colors: [
            AppColors.RNMBlack,
            AppColors.RNMLightGreen,
            AppColors.RNMYellow,
            AppColors.RNMGreenWithOpacity,
            AppColors.RNMWhite,
            AppColors.RNMWhite,
            AppColors.RNMWhite
          ],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                if (showBackButton)
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20),
                    onPressed: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(const TabSelected(0));
                    },
                  ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/app-logo.png',
                      height: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
