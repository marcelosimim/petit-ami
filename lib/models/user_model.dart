import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var firebaseUser;
  var uid;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users").doc(_auth.currentUser!.uid.toString()).set(userData).then((value) => print('ok'))
        .catchError((error) => print('error: '+error));
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser!;
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid.toString())
            .get();
        userData = {
          'name': docUser['name'],
          'email': docUser['email'],
          'current_unit': docUser['current_unit'],
          'current_exercise': docUser['current_exercise']
        };
      }
    }
    notifyListeners();
  }

  bool updateUserData(String? name, String? password) {
    String currentUserID = firebaseUser.uid;
    var snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .update({'name': name == null ? userData['name'] : name});
    notifyListeners();

    return true;
  }

  void setUnit(int unit) {}

  void setExercise(int increment) {
    print('setExercise');
    print('userdata: ${userData['current_exercise']}');
    print('increment: ${increment}');
    String currentUserID = _auth.currentUser!.uid.toString();
    var snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .update({'current_exercise' : userData['current_exercise']+increment});
    userData['current_exercise'] += increment;
    notifyListeners();
  }

  void changeUserData(String? name, String? password) {
    //this.userData
  }

}
