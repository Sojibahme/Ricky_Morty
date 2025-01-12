import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ricky_morty/presentation/widgets/custom_app_bar.dart';
import 'package:ricky_morty/presentation/widgets/info_card.dart';
import 'package:ricky_morty/presentation/widgets/episode_card.dart';
import 'package:ricky_morty/utils/colors.dart';

class CastDetailsScreen extends StatelessWidget {
  final String? characterId;

  const CastDetailsScreen({Key? key, required this.characterId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characterId == null) {
      return Scaffold(
        backgroundColor: AppColors.RNMBlack,
        appBar: AppBar(
          backgroundColor: AppColors.RNMBlack,
          title: const Text('Character Details',
              style: TextStyle(color: AppColors.RNMBlack)),
        ),
        body: const Center(
          child: Text('Please select a character.',
              style: TextStyle(color: AppColors.RNMBlack)),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(showBackButton: true),
            Query(
              options: QueryOptions(
                document: gql('''
                  query GetCharacter(\$id: ID!) {
                    character(id: \$id) {
                      id
                      name
                      status
                      species
                      image
                      gender
                      origin {
                        name
                      }
                      location {
                        name
                      }
                      episode {
                        name
                      }
                    }
                  }
                '''),
                variables: {'id': characterId},
              ),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        stops: const [1.0, 0.0, 0.1, 0.3, 0.5, 0.7, 0.8],
                        colors: [
                          AppColors.RNMBlack,
                          AppColors.RNMLightGreen,
                          AppColors.RNMYellow,
                          AppColors.RNMGreenWithOpacity,
                          AppColors.RNMWhite.withOpacity(0.3),
                          AppColors.RNMWhite.withOpacity(0.5),
                          AppColors.RNMWhite
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(color: AppColors.RNMBlack),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    ),
                  );
                }

                if (result.hasException) {
                  return Center(
                    child: Text(
                      'Please select a character.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        color: AppColors.RNMBlue,
                      ),
                    ),
                  );
                }

                final character = result.data!['character'];

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(character['image']),
                      fit: BoxFit.cover,
                      opacity: 0.1,
                    ),
                    gradient: LinearGradient(
                      stops: [1.0, 0.0, 0.1, 0.3, 0.5, 0.7, 0.8],
                      colors: [
                        AppColors.RNMBlack,
                        AppColors.RNMLightGreen,
                        AppColors.RNMYellow,
                        AppColors.RNMGreenWithOpacity,
                        AppColors.RNMWhite.withOpacity(0.3),
                        AppColors.RNMWhite.withOpacity(0.5),
                        AppColors.RNMWhite
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              character['name'],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.RNMTextBlue,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                ClipPath(
                                  child: Container(
                                    width: 240,
                                    height: 240,
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
                                  width: 238,
                                  height: 238,
                                  margin: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF193840),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          character['image'],
                                          width: 180,
                                          height: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: InfoCard(
                                        title: 'Status',
                                        value: character['status'],
                                        isOriginAndLastLocation: false,
                                        icon: 'assets/icons/icon-status.png',
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InfoCard(
                                        icon: 'assets/icons/icon-species.png',
                                        title: 'Species',
                                        value: character['species'],
                                        isOriginAndLastLocation: false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InfoCard(
                                        icon: 'assets/icons/icon-gender.png',
                                        title: 'Gender',
                                        value: character['gender'],
                                        isOriginAndLastLocation: false,
                                      ),
                                    ),
                                  ],
                                ),
                                InfoCard(
                                  icon: 'assets/icons/icon-origin.png',
                                  title: 'Origin',
                                  value: character['origin']['name'],
                                  isOriginAndLastLocation: true,
                                ),
                                InfoCard(
                                  icon: 'assets/icons/icon-location.png',
                                  title: 'Last Known Location',
                                  value: character['location']['name'],
                                  isOriginAndLastLocation: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            EpisodeCard(
                              episodes: character['episode']
                                  .map<String>((ep) => '${ep['name']}')
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
