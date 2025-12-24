import 'package:cloud_firestore/cloud_firestore.dart';

class DBhelper {
  DBhelper._privateConstructor();
  static final DBhelper instance = DBhelper._privateConstructor();

  // 🔹 Collection name (instead of table)
  static const String TABLE_NAME = "users";

  // 🔹 Field names (same as your SQLite columns)
  static const String USER_ID = "id";
  static const String USER_NAME = "full_name";
  static const String USER_EMAIL = "email";
  static const String USER_AGE = "age";
  static const String USER_GENDER = "gender";

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 INSERT USER (Firestore)
  Future<void> insertUser({
    required String uid,
    required String fullName,
    required String email,
    required int age,
    required String gender,
  }) async {
    await _firestore.collection(TABLE_NAME).doc(uid).set({
      USER_ID: uid,
      USER_NAME: fullName,
      USER_EMAIL: email,
      USER_AGE: age,
      USER_GENDER: gender,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // 🔹 GET USER BY ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
      String uid) async {
    return await _firestore
        .collection(TABLE_NAME)
        .doc(uid)
        .get();
  }

  // 🔹 UPDATE USER
  Future<void> updateUser(
      String uid, Map<String, dynamic> data) async {
    await _firestore
        .collection(TABLE_NAME)
        .doc(uid)
        .update(data);
  }

  // 🔹 DELETE USER
  Future<void> deleteUser(String uid) async {
    await _firestore
        .collection(TABLE_NAME)
        .doc(uid)
        .delete();
  }
}
