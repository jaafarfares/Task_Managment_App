import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserFromFirestore(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
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
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
        });

        return UserModel(id: user.uid, name: name, email: email);
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth error during sign up: $e");
      rethrow;
    } catch (e) {
      print("Unexpected error during sign up: $e");
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
        return await getUserFromFirestore(user.uid);
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth error during sign in: $e");
      rethrow;
    } catch (e) {
      print("Unexpected error during sign in: $e");
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
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
