import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personality_tracker/Database/db_helper.dart';
import 'package:personality_tracker/Screens/Login_SignUp/login_page.dart';

class Signup extends StatefulWidget{
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var fullname= TextEditingController();
  var email=TextEditingController();
  var pass=TextEditingController();
  var confirmpass=TextEditingController();
  var age = TextEditingController();
  var gender=TextEditingController();


 DBhelper dBhelper = DBhelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text("Sign Up",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87,),),
              SizedBox(height: 6,),
              Text("Sign Up to Track Your Personality",style: TextStyle(fontSize: 20,color: Colors.grey.shade600),textAlign: TextAlign.center,),
              SizedBox(height: 30),

              // Full Name
              TextField(
                controller: fullname,
                decoration: InputDecoration(
                  labelText:"Full Name",
                  prefixIcon: Icon(Icons.account_circle),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide(color: Colors.blue,width: 1.5)
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Email
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText:"Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.blue,width: 1.5)
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Password
              TextField(
                controller: pass,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  labelText:"Password",
                  prefixIcon: Icon(Icons.password),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.blue,width: 1.5)
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Confirm Password
              TextField(
                controller: confirmpass,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  labelText:"Confirm Password",
                  prefixIcon: Icon(Icons.password),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.blue,width: 1.5)
                  ),
                ),
              ),
              SizedBox(height: 15),

              //Age
              TextField(
                controller: age,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Age",
                  prefixIcon: Icon(Icons.cake_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.blue,width: 1.5)
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Gender
              TextField(
                controller: gender,
                decoration: InputDecoration(
                  labelText:"Gender",
                  prefixIcon: Icon(Icons.wc_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: Colors.blue,width: 1.5)
                  ),
                ),
              ),
              SizedBox(height: 20),


              SizedBox(
                width: 120,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    elevation: 3,
                  ),
                  onPressed: () async {
                    // Trim inputs
                    String name = fullname.text.trim();
                    String mail = email.text.trim();
                    String password = pass.text.trim();
                    String confirmPassword = confirmpass.text.trim();
                    int userAge = int.tryParse(age.text.trim()) ?? 0;
                    String userGender = gender.text.trim();

                    if (name.isEmpty ||
                        mail.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty ||
                        userGender.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill all fields",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password Do Not Match",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    try {
                      // 🔐 Firebase Auth signup
                      UserCredential userCredential =
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: mail,
                        password: password,
                      );

                      String uid = userCredential.user!.uid;

                      // 🔥 Firestore insert using YOUR DBhelper
                      await DBhelper.instance.insertUser(
                        uid: uid,
                        fullName: name,
                        email: mail,
                        age: userAge,
                        gender: userGender,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User Registered Successfully",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => Loginpage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registration Failed",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}