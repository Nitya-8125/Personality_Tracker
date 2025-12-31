import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personality_tracker/Screens/Login_SignUp/login_page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirmpass = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                "Sign Up to Track Your Personality",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Full Name
              TextField(
                controller: fullname,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.account_circle),
                ),
              ),
              const SizedBox(height: 15),

              // Email
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 15),

              // Password
              TextField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password
              TextField(
                controller: confirmpass,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 15),

              // Age
              TextField(
                controller: age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  prefixIcon: Icon(Icons.cake_outlined),
                ),
              ),
              const SizedBox(height: 15),

              // Gender
              TextField(
                controller: gender,
                decoration: const InputDecoration(
                  labelText: "Gender",
                  prefixIcon: Icon(Icons.wc_outlined),
                ),
              ),
              const SizedBox(height: 25),

              // Submit Button
              SizedBox(
                width: 140,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    String name = fullname.text.trim();
                    String mail = email.text.trim();
                    String password = pass.text.trim();
                    String confirmPassword = confirmpass.text.trim();
                    int userAge = int.tryParse(age.text.trim()) ?? 0;
                    String userGender = gender.text.trim();

                    // 🔎 Validation
                    if (name.isEmpty ||
                        mail.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty ||
                        userGender.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    try {
                      // 🔐 Firebase Authentication
                      UserCredential userCredential =
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: mail,
                        password: password,
                      );

                      String uid = userCredential.user!.uid;

                      // 🔥 Store user data in Firestore
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .set({
                        "uid": uid,
                        "name": name,
                        "email": mail,
                        "age": userAge,
                        "gender": userGender,
                        "provider": "email",
                        "createdAt": FieldValue.serverTimestamp(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("User Registered Successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // 🔙 Back to Login page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Loginpage(),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message ?? "Registration failed"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
