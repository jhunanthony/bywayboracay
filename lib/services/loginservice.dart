import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  //encapsulate firebase hooks to project from the cloud

  LoginService() {
    Firebase.initializeApp();
  }

  UserLogInModel _userModel;

  UserLogInModel get loggedInUserModel => _userModel;

  //create method that return
  Future<bool> signInWithGoogle() async {
    //Trigger the authentication flow
    GoogleSignIn googleSignIn = GoogleSignIn();

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
      );
    }

    return true;
  }

  //for sign out
  void signOut() async {
    await GoogleSignIn().signOut();
    _userModel = null;
  }
}
