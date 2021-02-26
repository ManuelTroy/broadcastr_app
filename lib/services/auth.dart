import 'package:broadcastr_ui/models/user.dart';
import 'package:broadcastr_ui/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user  != null ? User(uid: user.uid) : null;

  }

   // auth change user stream
   Stream<User> get user {
     return _auth.onAuthStateChanged
     .map(_userFromFirebaseUser);
   }
   
  // sign in with email & password
    Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

    }

    
  // sign in with phone number
    
    
  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;


      // create new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new creator', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }

    }



  // regster with phone number 

  // sign out
   Future signOut()  async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.string());
      return null;

    }

    }

   }

