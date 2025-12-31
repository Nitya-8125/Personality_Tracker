import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<void> saveUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref =
    FirebaseFirestore.instance.collection("users").doc(user.uid);

    if (!(await ref.get()).exists) {
      await ref.set({
        "uid": user.uid,
        "name": user.displayName ?? "User",
        "email": user.email,
        "photoUrl": user.photoURL,
        "provider": user.providerData.first.providerId,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }
  }
}
