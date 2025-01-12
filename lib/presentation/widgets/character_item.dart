import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricky_morty/data/models/character_model.dart';
import 'package:ricky_morty/domain/entities/character.dart';
import 'package:ricky_morty/utils/colors.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel characterModel;

  const CharacterItem({Key? key, required this.characterModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = _convertToCharacter();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 200,
          maxHeight: 250,
        ),
        child: Stack(
          children: [
            // Gradient background
            Container(
              width: 200,
              height: 250,
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
            // Content container
            Container(
              width: 198,
              height: 240,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: AppColors.RNMBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          character.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Spacing
                    const SizedBox(height: 10),
                    // Character name
                    Text(
                      character.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Character _convertToCharacter() {
    return Character(
      id: characterModel.id,
      name: characterModel.name,
      image: characterModel.image,
    );
  }
}