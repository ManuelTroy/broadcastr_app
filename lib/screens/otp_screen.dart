import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigatorBar.dart';
import 'otp_input.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber, phone;
  OTPScreen({Key key, @required this.phone, @required this.mobileNumber})
      : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _pinEditingController = TextEditingController();

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    print("isValid - $isCodeSent");
    print("mobile ${widget.mobileNumber}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(height: 30.0),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 10.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 5.0, bottom: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please wait OTP in sent to ${widget.mobileNumber}",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    "Enter Your OTP number",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PinInputTextField(
                      pinLength: 6,
                      decoration: BoxLooseDecoration(
                        solidColor: Colors.white,
                        hintText: '000000',
                      ),
                      controller: _pinEditingController,
                      textInputAction: TextInputAction.done,
                      onSubmit: (pin) {
                        if (pin.length == 6) {
                          _onFormSubmitted();
                        } else {
                          showToast("Invalid OTP", Colors.red);
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        if (_pinEditingController.text.length == 6) {
                          _onFormSubmitted();
                        } else {
                          showToast("Invalid OTP", Colors.red);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          gradient: LinearGradient(
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.white,
                                Colors.green,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Enter OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                ],
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          // Handle loogged in state
          saveUserInfo();
          print(value.user.phoneNumber);
          Navigator.of(context).pop();

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyNavigationBar()));
        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed = (authException) {
      print(authException.message + 'I am the error');
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) {
      if (value.user != null) {
        saveUserInfo();
        // Handle logged in state
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyNavigationBar()));
        print(value.user.phoneNumber);
      } else {
        showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.red);
    });
  }

  displayDialog(String message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Remember Your Password"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  _signOut();
                  Navigator.of(context).pop(true);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => SignInPage()),
                  //   (route) => false,
                  // );
                },
              )
            ],
          );
        });
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

const List<Color> orangeToRed_Gradient = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

void showToast(message, Color color) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

void saveUserInfo() async {
  var preferences = await SharedPreferences.getInstance();

  preferences.setBool("User", true);
}
