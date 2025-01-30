import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_login_google/config/constant/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.initEnvironment();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.androidFirebaseOption()
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Building title'),
      ),
      body: Center(
        child: Text(Environment.keyAuthGoogle),
      ),
    );
  }
}
