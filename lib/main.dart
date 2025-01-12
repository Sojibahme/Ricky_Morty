import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ricky_morty/data/graphql/graphql_service.dart';
import 'package:ricky_morty/data/repositories/character_repository.dart';
import 'package:ricky_morty/domain/repositories/character_repository.dart';
import 'package:ricky_morty/presentation/blocs/character/character_bloc.dart';
import 'package:ricky_morty/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:ricky_morty/presentation/screens/all_cast_screen.dart';
import 'package:ricky_morty/presentation/screens/cast_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/presentation/screens/navigation_screen.dart';
import 'package:ricky_morty/presentation/screens/signin_screen.dart';
import 'package:ricky_morty/presentation/screens/splash_screen.dart';
import 'package:ricky_morty/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for GraphQL Flutter
  await initHiveForFlutter();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Register AuthService
  getIt.registerSingleton<AuthService>(AuthService(prefs));

  // Set up GraphQL Client
  final httpLink = HttpLink('https://rickandmortyapi.com/graphql');
  final graphQLClient = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );
  getIt.registerSingleton<GraphQLClient>(graphQLClient);

  // Register GraphQL Service
  final graphQLService = GraphQLService(graphQLClient);
  getIt.registerSingleton<GraphQLService>(graphQLService);

  // Register Character Repository
  final characterRepository = CharacterRepositoryImpl(graphQLService);
  getIt.registerSingleton<CharacterRepository>(characterRepository);
}

void main() async {
  try {
    await initializeDependencies();
    runApp(MyApp());
  } catch (e, stackTrace) {
    debugPrint('Error during initialization: $e');
    debugPrint('Stack trace: $stackTrace');
    // You might want to show some error UI here
    runApp(ErrorApp(error: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(getIt<GraphQLClient>()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CharacterBloc(getIt<CharacterRepository>()),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rick and Morty App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
            future: getIt<AuthService>().isSignedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              return snapshot.data == true
                  ? NavigationScreen()
                  : SignInScreen(authService: getIt<AuthService>());
            },
          ),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(
                  builder: (_) => NavigationScreen(),
                );
              case '/castDetails':
                final characterId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (_) => CastDetailsScreen(characterId: characterId),
                );
              default:
                return MaterialPageRoute(
                  builder: (_) => SplashScreen(),
                );
            }
          },
        ),
      ),
    );
  }
}

// Simple error screen in case initialization fails
class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to start the app',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}