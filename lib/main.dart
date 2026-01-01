import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personality_tracker/Screens/Intro%20Page/intro_page1.dart';

import 'Screens/Intro Page/splash_screen.dart';
import 'Screens/Home Page/Homepage.dart';
import 'Screens/Login_SignUp/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personality Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const AuthWrapper(),
    );
  }
}

/// 🔥 THIS DECIDES WHERE TO GO (HOME / LOGIN)
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Splashscreen();
        }

        // ✅ User logged in
        if (snapshot.hasData) {
          return  Homepage();
        }

        // ❌ User not logged in
        return  IntroPage();
      },
    );
  }
}
