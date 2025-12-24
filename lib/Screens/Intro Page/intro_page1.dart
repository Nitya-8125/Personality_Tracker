import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personality_tracker/Screens/Intro Page/splash_screen.dart';
import 'package:personality_tracker/Screens/Login_SignUp/login_page.dart';
import 'package:personality_tracker/Screens/Home Page/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: Splashscreen(),
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/intro_page/Saly-1.png',
              width: 350,
              height: 370,
            ),
          ),
           SizedBox(height: 100),
           Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Discover Your True Self",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Uncover the unique traits that make you… you.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Loginpage()),
          );
        },
        backgroundColor: Colors.black87,
        child: Icon(Icons.navigate_next, weight: 15, color: Colors.white),
      ),
    );
  }
}
