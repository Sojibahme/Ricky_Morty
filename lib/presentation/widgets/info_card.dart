import 'package:flutter/material.dart';
import 'package:ricky_morty/utils/colors.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final bool isOriginAndLastLocation;

  InfoCard(
      {required this.title,
      required this.value,
      required this.isOriginAndLastLocation,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(0.1),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.RNMGreen,
              AppColors.RNMBlue,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipPath(
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.RNMGreen,
                      AppColors.RNMBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 98,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: AppColors.RNMBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(icon),
                    width: 22,
                    height: 23,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          value,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (isOriginAndLastLocation)
                        const Image(
                          image: AssetImage('assets/icons/icon-link.png'),
                          width: 15,
                          height: 15,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
