import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLogIn = false;

  @override
  void initState() {
    super.initState();
    _listenAuthUser();
  }

  _listenAuthUser() {
    FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) {
        setState(() {
          isLogIn = user != null;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconButton(
              textButton: 'Google',
              onPressed: isLogIn ? null : _signIn,
            ),
            _buildIconButton(
              textButton: 'Log Out!',
              onPressed: isLogIn ? _signOut : null
            )
          ],
        ),
      ),
    );
  }

  _signIn() async {
    await _signInGoogle();
  }

  _signOut() async {
    final result = await GoogleSignIn().signOut();
    
    setState(() {
      isLogIn = result != null;
    });
  }
}

Widget _buildIconButton({
  required String textButton,
  void Function()? onPressed,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    label: Text(textButton),
  );
}

Future<UserCredential?> _signInGoogle() async {
 final GoogleSignInAccount? googleUser = await _getGoogleUser();

 if (googleUser != null) {
  final GoogleSignInAuthentication? googleAuth =
    await _getGoogleSignInAuthentication(googleUser);

  if (googleAuth != null) {
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    // ! throw GoogleAuth is null
    return null;
  }
 } else {
  // ! Google User is null
  return null;
 }
}

// Obtain the auth datails from the request
Future<GoogleSignInAuthentication?> _getGoogleSignInAuthentication(GoogleSignInAccount googleUser) async {
  try {
    return await googleUser.authentication;
  } catch (ex) {
    return null;
  }
}

// Trigger the authentication flow
Future<GoogleSignInAccount?> _getGoogleUser() async {
  try {
    return await GoogleSignIn().signIn();
  } catch (ex) {
    return null;
  }
}
