import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personality_tracker/Database/db_helper.dart';
import 'package:personality_tracker/Screens/Login_SignUp/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userpage extends StatefulWidget {
  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  String name = "";
  String email = "";


  @override
  void initState() {
    super.initState();
    loadUserData();
  }



  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("uid");

    if (uid != null) {
      final snapshot = await DBhelper.instance.getUser(uid);

      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()![DBhelper.USER_NAME];
          email = snapshot.data()![DBhelper.USER_EMAIL];
        });
      }
    }

  }

  void logoutuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // remove session
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        titleSpacing: 15,
        elevation: 5,
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(6.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.blueAccent,
              size: 22,
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 35),
            Center(
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const .all(16.0),
        child: Column(
          children: [
            // Profile Card
            Card(
              elevation: 5,
              shadowColor: Color(0x4D2196F3),
              shape: RoundedRectangleBorder(
                borderRadius: .circular(20),
              ),
              child: ListTile(
                contentPadding:
                .symmetric(horizontal: 20, vertical: 10),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(Icons.account_circle,
                      size: 40, color: Colors.blueAccent),
                ),
                title: Text(name,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                subtitle: Text(email,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                trailing: IconButton(
                  onPressed: () {
                    // TODO: Edit logic
                  },
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Settings Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: .circular(15)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.blueAccent),
                    title: Text("Privacy Settings"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward,
                          color: Colors.grey, size: 18),
                    ),
                  ),

                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.edit, color: Colors.blueAccent),
                    title: Text("Edit Profile"),
                    trailing: IconButton(
                      onPressed: () {
                        // TODO Logic
                      },
                      icon: Icon(Icons.arrow_forward,
                          color: Colors.grey, size: 18,
                      ),
                    ),
                  ),

                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blueAccent),
                    title: Text("Notifications"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward,
                          color: Colors.grey, size: 18),
                    ),
                  ),


                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.security, color: Colors.blueAccent),
                    title: Text("Security"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward,
                          color: Colors.grey, size: 18),
                    ),
                  ),


                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.help_outline, color: Colors.blueAccent),
                    title: Text("Help & Support"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward,
                          color: Colors.grey, size: 18),
                    ),
                  ),


                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.blueAccent),
                    title: Text("About App"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward,
                          color: Colors.grey, size: 18),
                    ),
                  ),


                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.redAccent),
                    title:
                    Text("Logout", style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: IconButton(
                      onPressed: () {
                        logoutuser();
                      },
                      icon: Icon(Icons.exit_to_app, color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
