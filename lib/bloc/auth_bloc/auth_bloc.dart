import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:login_task/models/user_model_auth.dart';
import 'package:login_task/services/firestore_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _user = BehaviorSubject<UserModelAuth>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // get Data from stream

  Stream<String> get email => _emailSubject.stream.transform(_validateEmail);
  Stream<String> get password =>
      _passwordSubject.stream.transform(_validatePassword);
  Stream<UserModelAuth> get user => _user.stream;
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);

  // setting email and password

  Function(String) get settingEmail => _emailSubject.sink.add;
  Function(String) get settingPassword => _passwordSubject.sink.add;

// closing streams

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _user.close();
  }

  //validating  email and password before putting in stream

  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (emailValidatingRegx.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError('Enter The Valid Email Address');
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('Password Must Be Minimun 8 Characters');
    }
  });

  //Functions
  signupEmail() async {
    try {
      UserCredential signingUP = await _auth.createUserWithEmailAndPassword(
          email: _emailSubject.value.trim(),
          password: _passwordSubject.value.trim());

      var user = UserModelAuth(
          userId: signingUP.user.uid, email: _emailSubject.value.trim());
      await _firestoreService.addUser(user);

      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  loginEmail() async {
    try {
      UserCredential loginWithEmailAuth =
          await _auth.signInWithEmailAndPassword(
              email: _emailSubject.value.trim(),
              password: _passwordSubject.value.trim());
      var user = await _firestoreService.fetchUser(loginWithEmailAuth.user.uid);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
    }
  }
}

//Regx for validating email

final RegExp emailValidatingRegx = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final authBloc = AuthBloc();
