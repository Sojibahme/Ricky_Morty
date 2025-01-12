import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricky_morty/presentation/blocs/character/character_bloc.dart';
import 'package:ricky_morty/presentation/blocs/character/character_event.dart';
import 'package:ricky_morty/presentation/blocs/character/character_state.dart';
import 'package:ricky_morty/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:ricky_morty/presentation/widgets/bottom_loader.dart';
import 'package:ricky_morty/presentation/widgets/character_item.dart';
import 'package:ricky_morty/presentation/widgets/custom_app_bar.dart';
import 'package:ricky_morty/utils/colors.dart';

class AllCastScreen extends StatefulWidget {
  @override
  _AllCastScreenState createState() => _AllCastScreenState();
}

class _AllCastScreenState extends State<AllCastScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialCharacters();
  }

  void _fetchInitialCharacters() {
    context.read<CharacterBloc>().add(const FetchCharacters(1));
  }

  void _onScroll() {
    if (_isBottom) {
      final currentPage = context.read<CharacterBloc>().currentPage;
      context.read<CharacterBloc>().add(FetchCharacters(currentPage));
    }
  }

  bool get _isBottom {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: _buildBackgroundDecoration(),
      child: Column(
        children: [
          CustomAppBar(),
          _buildHeader(),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterInitial || state is CharacterLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                } else if (state is CharacterLoaded) {
                  return _buildCharacterGrid(state);
                } else if (state is CharacterError) {
                  return const Center(
                    child: Text('Failed to fetch characters'),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      color: AppColors.RNMBlack,
      image: DecorationImage(
        image: const AssetImage('assets/images/all-cast-bg.png'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3),
          BlendMode.dstATop,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          Text(
            'All Cast',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.RNMTextBlue,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterGrid(CharacterLoaded state) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: state.hasReachedMax
          ? state.characters.length
          : state.characters.length + 1,
      itemBuilder: (context, index) {
        if (index >= state.characters.length) {
          return BottomLoader();
        } else {
          final characterModel = state.characters[index];
          return GestureDetector(
            onTap: () {
              context
                  .read<NavigationBloc>()
                  .add(ShowCastDetails(characterModel.id));
            },
            child: CharacterItem(characterModel: characterModel),
          );
        }
      },
    );
  }
}
