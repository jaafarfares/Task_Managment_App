import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Load user data from SharedPreferences (for app restart)
  // Future<UserModel?> loadUserFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString('userId');
  //   if (userId != null) {
  //     return await getUserFromFirestore(userId);
  //   }
  //   return null;
  // }

  Future<UserModel?> getUserFromFirestore(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc); 
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
        });

        // Save user data in SharedPreferences (commented out for now)
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('userId', user.uid);

        return UserModel(id: user.uid, name: name, email: email);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('userId', user.uid); // Commented out for now
        return await getUserFromFirestore(user.uid);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();

    // Clear SharedPreferences (commented out for now)
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('userId');
  }

  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user != null) {
        return await getUserFromFirestore(user.uid);
      }
      return null;
    });
  }
}
