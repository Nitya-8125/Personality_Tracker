
import 'package:flutter/material.dart';
import 'package:personality_tracker/Database/user_service.dart';
import 'package:personality_tracker/Screens/Home Page/Homepage.dart';
import 'package:personality_tracker/Screens/Login_SignUp/sign_up.dart';
import 'package:personality_tracker/Screens/User_Screens/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  Future<void> _googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      await UserService.saveUser();

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo / Image
              Image.asset(
                'assets/login_signup/Saly-12.png',
                width: 180,
              ),
              SizedBox(height: 20),

              // Title
              Text(
                "Welcome Back 👋",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Login to continue tracking your personality",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // Email Field
              TextField(
                controller: username,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Password Field
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () async{
                      String user = username.text.trim();
                      String login_pass = password.text.trim();

                      if (user.isEmpty || login_pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please Fill All Fields",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: user,
                          password: login_pass,
                        );

                        // 🔥 Store user in Firestore (if not exists)
                        await UserService.saveUser();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Successful"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // ✅ DO NOT navigate
                        // main.dart will automatically open Homepage

                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid email or password"),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Signup Link
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: Image.asset(
                    "assets/login_signup/google.png",
                    height: 22,
                  ),
                  label: Text(
                    "Sign in with Google",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  onPressed: _googleSignIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
