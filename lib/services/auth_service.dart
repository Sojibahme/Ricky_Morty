import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final SharedPreferences prefs;

  AuthService(this.prefs);

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        await prefs.setString('user_email', account.email);
        await prefs.setString('user_name', account.displayName ?? '');
        await prefs.setString('user_photo', account.photoUrl ?? '');
      }
      return account;
    } catch (error) {
      print('Sign in error: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await prefs.clear();
  }

  Future<bool> isSignedIn() async {
    // Add a small delay to ensure SharedPreferences is properly initialized
    await Future.delayed(const Duration(milliseconds: 100));
    return prefs.containsKey('user_email');
  }

  Future<Map<String, String>> getUserData() async {
    return {
      'email': prefs.getString('user_email') ?? '',
      'name': prefs.getString('user_name') ?? '',
      'photo': prefs.getString('user_photo') ?? '',
    };
  }
}