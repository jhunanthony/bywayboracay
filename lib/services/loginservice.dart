import 'package:bywayborcay/models/UserLogInModel.dart';

import 'package:bywayborcay/widgets/CalendarWidget/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final databaseReference = FirebaseFirestore.instance;

class LoginService extends ChangeNotifier {
  //encapsulate firebase hooks to project from the cloud

  UserLogInModel _userModel;

  UserLogInModel get loggedInUserModel => _userModel;

  //create method that return
  Future<bool> signInWithGoogle() async {


    //Trigger the authentication flow
    GoogleSignIn googleSignIn = GoogleSignIn(
     
    );

     


    //fetch account information by calling sign in method
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return false;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    //create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //fetch the details
    //once signed in, return the user credential
    UserCredential userCreds =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCreds != null) {
      //collect user info
      //populate _usermodel upon receiving credentials
      _userModel = UserLogInModel(
        displayName: userCreds.user.displayName,
        photoUrl: userCreds.user.photoURL,
        email: userCreds.user.email,
        //extract user id

        uid: userCreds.user.uid,
      );
    }

    notifyListeners();

    return true;
  }


  /*void googleSignIn()  {
    Auth().signInWithGoogle().then((user) async {
     await databaseReference.collection('Users').doc(user.uid).get();
    });
  }*/

  //for sign out
  void signOut() async {
    await GoogleSignIn().signOut();
    Auth().signOut();
    _userModel = null;
  }

   

  //check if user is logged or not
  bool isUserLoggedIn() {
    return _userModel != null;
  }
}
