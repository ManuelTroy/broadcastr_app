import 'package:broadcastr_ui/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigatorBar.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

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
        title: Text('Email Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              // onPressed: () => widget.toggleView(),
              onPressed: () {}),
        ],
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
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(height: 10.0),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
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
                    // }

                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) {
                      Navigator.of(context).pop();

                      if (value.user != null) {
                        saveUserInfo();
                        print("UserCreated");
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyNavigationBar()));
                      }
                    }).catchError((onError) {
                      Navigator.of(context).pop();

                      print(onError);
                      showToast("Network error!", Colors.red);
                    });
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

  void saveUserInfo() async {
    var preferences = await SharedPreferences.getInstance();

    preferences.setBool("User", true);
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
