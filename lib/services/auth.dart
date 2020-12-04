import 'package:chatapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMehtods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  static AuthMehtods _instance;

  AuthMehtods._createInstance();

  factory AuthMehtods() {
    if (_instance == null) _instance = AuthMehtods._createInstance();

    return _instance;
  }

  // static AuthMehtods newInst() {
  //   if (_instance == null) _instance = AuthMehtods._createInstance();

  //   return _instance;
  // }

  User get user => _auth?.currentUser;

  Future<User> signInWithEmailAndPassword(
    //signup ??

    final String email,
    final String password, {
    String username,
    bool newUser = false, // true = sign up
  }) async {
    UserCredential userCred;

    try {
      if (newUser) {
        userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else
        userCred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
    } catch (e) {
      throw e;
    } finally {
      if (userCred != null) {
        await userCred.user.updateProfile(displayName: username);
        await DatabaseMethods().uploadUserInfo(
            user.uid, {"name": user.displayName, "email": user.email});
      }
    }

    debugPrint('Signed up as ${user?.displayName}');

    return user;
  }

// For Google SignIn
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount goolgeSignInAccount = await googleSignIn.signIn();
    print(goolgeSignInAccount);
    final GoogleSignInAuthentication googleSignInAuthentication =
        await goolgeSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    print(credential.asMap());

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User user = authResult.user;

    return user;
  }

  Future<void> signoutGoogle() async {
    await googleSignIn.signOut();

    print('User sign out');
  }

  Future<void> signOut() => _auth.signOut();
}
