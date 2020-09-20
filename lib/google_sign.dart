import 'package:course_management_system/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String uname, uemail, uphoto;

Future<String> signInWIthGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final auth.UserCredential authResult =
      await _auth.signInWithCredential(credential);

  final auth.User user = authResult.user;

  assert(user.email != null);
  assert(user.displayName != null);

  auth.User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);

  Constants.prefs.setString("uname", currentUser.displayName);
  Constants.prefs.setString("uemail", currentUser.email);
  Constants.prefs.setString("uphoto", currentUser.photoURL);

  return 'signInWithGoogle succeeded: $user';
}
