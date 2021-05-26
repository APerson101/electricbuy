import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'abstractComand.dart';

class WebSignIn extends AbstractCommand {
  FirebaseAuth auth;
  WebSignIn(BuildContext buildContext) : super(buildContext) {
    auth = FirebaseAuth.instance;
  }

  executeSignIn() async {
    print('initiating sign in sequence');
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.setCustomParameters({'prompt': 'select_account'});
      UserCredential signedInUser =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      print(signedInUser.user.displayName);
      return signedInUser;
    } catch (e) {
      print(e);
    }
  }

  executeSignOut() async {
    print('signing out');
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e);
    }
  }
}
