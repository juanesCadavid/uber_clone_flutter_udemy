import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  bool isSignedIn(){
    final currenUser = _firebaseAuth.currentUser;

    if(currenUser == null){
      return false;
    }
    return true;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  // void checkIfUserIsLogin(BuildContext context, String typeUser) {
  //   FirebaseAuth.instance.authStateChanges().listen((User user) {
  //     if (user != null && typeUser != null) {
  //       if(typeUser == 'client'){
  //         Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
  //       }else if(typeUser == 'driver'){
  //         Navigator.pushNamedAndRemoveUntil(context, 'driver/map', (route) => false);
  //       }
  //     }
  //   });
  // }

  Future<bool> login(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error);
      errorMessage = error.code;
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> register(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error);
      errorMessage = error.code;
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<void> signOut()async{
    return Future.wait([_firebaseAuth.signOut()]);
  }

}
