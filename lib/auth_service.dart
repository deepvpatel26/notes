import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> googleSignin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        try {
          UserCredential userCredential =
          await auth.signInWithCredential(credential);

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
                  (route) => false);
        } catch (e) {
          print(e);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            duration: const Duration(milliseconds: 3000),
          ));
        }
      } else {
        print("google acc is null");
      }
    } catch (e) {
      print(e);
    }
  }



  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print('$e + Error while signing out');
    }
  }


}