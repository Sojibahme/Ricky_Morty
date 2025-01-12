import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricky_morty/utils/colors.dart';

class EpisodeCard extends StatelessWidget {
  final List<String> episodes;

  EpisodeCard({required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.RNMGreen,
              AppColors.RNMBlue,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.RNMBlack,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/icon-episodes.png',
                  width: 22,
                  height: 23,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Episode(s)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: episodes
                      .map((episode) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              '• $episode',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
