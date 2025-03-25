import 'package:cutfx/utils/app_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginClickEvent>((event, emit) async {
      if (event.type == 0) {
        AppRes.showCustomLoader();
        User? user = await signInWithApple();
        AppRes.loginWithFirebase(user, 1);
      } else if (event.type == 1) {
        AppRes.showCustomLoader();
        User? user = await signInWithGoogle();
        AppRes.loginWithFirebase(user, 2);
      }
    });
  }

  Future<User?> signInWithApple() async {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: result.identityToken,
      accessToken: result.authorizationCode,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;
    if (result.givenName != null && result.familyName != null) {
      final displayName = '${result.givenName} ${result.familyName}';
      await firebaseUser!.updateDisplayName(displayName);
    }
    return firebaseUser;
  }

  Future<User?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      if (googleSignInAuthentication == null) return null;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return null;
  }
}
