import 'package:easyupi/Screens/phone_number_entering_screen.dart';
import 'package:easyupi/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: () async {
              // Trigger the authentication flow
              final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

              // Obtain the auth details from the request
              final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

              // Create a new credential
              final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth?.accessToken,
                idToken: googleAuth?.idToken,
              );

              // Once signed in, return the UserCredential
              await FirebaseAuth.instance.signInWithCredential(credential);

              Get.offAll(PhoneNumberEnteringScreen());
            },
          ),
        ),
      ),
    );
  }
}
