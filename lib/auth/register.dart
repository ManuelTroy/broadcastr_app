import 'package:broadcastr_ui/NavigatorBar.dart';
import 'package:broadcastr_ui/screens/RegisterationForm.dart';
import 'package:broadcastr_ui/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  bool checkSignIn;
  Register(this.checkSignIn, {this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text(widget.checkSignIn ? 'Email Sign In' : 'Email Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter Email'),
              // validator: (val) => val.isEmpty ? 'Enter an email' : null,
              validator: (value) {
                Pattern pattern =
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    r"{0,253}[a-zA-Z0-9])?)*$";
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value) || value == null)
                  return 'Enter a valid email address';
                else
                  return null;
              },
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
                decoration: InputDecoration(hintText: 'Enter Password'),
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(height: 10.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                child: Text(
                  widget.checkSignIn ? 'Login' : 'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Dialog();
                  if (_formKey.currentState.validate()) {
                    // dynamic result = await _auth.registerWithEmailAndPassword(
                    //     email, password);
                    // if (result == null) {
                    //   setState(() {
                    //     error = 'Please supply a valid email';
                    //   });
                    // }\

                    if (widget.checkSignIn) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) {
                        if (value.user != null) {
                          saveUserInfo(value.user.uid);
                          print("UserCreated  " + value.user.uid);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyNavigationBar(index: 0)));
                        } else {
                          showToast("User not exist Please SignUp", Colors.red);
                        }
                      }).catchError((onError) {
                        print(onError.message);
                        Navigator.of(context).pop();

                        showToast(
                            onError.message + "\n Please SignUp", Colors.red);
                      });
                    } else {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) {
                        Navigator.of(context).pop();

                        if (value.user != null) {
                          saveUserInfo(value.user.uid);
                          print("UserCreated  " + value.user.uid);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => RegistrationForm(
                                      email: email,
                                      password: password,
                                      uid: value.user.uid,
                                      PhoneNumber: "")));
                        }
                      }).catchError((onError) {
                        Navigator.of(context).pop();

                        print(onError);
                        showToast("Network error!", Colors.red);
                      });
                    }
                  }
                }),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ]),
        ),
      ),
    );
  }

  void saveUserInfo(String uid) async {
    var preferences = await SharedPreferences.getInstance();

    preferences.setBool("User", true);
    preferences.setString("UserId", uid);
  }

  void Dialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content:
                Container(child: Center(child: CircularProgressIndicator())),
          );
        });
  }
}
