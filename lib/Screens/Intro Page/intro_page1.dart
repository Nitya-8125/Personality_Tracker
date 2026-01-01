import 'package:flutter/material.dart';
import 'package:personality_tracker/Screens/Login_SignUp/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/intro_page/Saly-1.png',
              width: 350,
              height: 370,
            ),
          ),
          const SizedBox(height: 100),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Discover Your True Self",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(
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
            MaterialPageRoute(builder: (_) =>  Loginpage()),
          );
        },
        backgroundColor: Colors.black87,
        child: const Icon(Icons.navigate_next, color: Colors.white),
      ),
    );
  }
}
