import 'package:broadcastr_ui/auth/register.dart';
import 'package:broadcastr_ui/screens/sign_in_page.dart';
import 'package:broadcastr_ui/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:broadcastr_ui/homescreen.dart';
import 'package:flutter/material.dart';

class PhoneRegister extends StatefulWidget {
  @override
  _PhoneRegisterState createState() => _PhoneRegisterState();
}

class _PhoneRegisterState extends State<PhoneRegister> {

 final AuthService  _auth = AuthService();

  // text field state
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign Up'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
          body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
            child: Column(
              children: <Widget> [
                 SizedBox(height: 20.0),
                 TextFormField(
                   decoration: InputDecoration(
                     hintText: 'Enter Phone Number'
                   ),
                  onChanged: (val) {
                    setState(() => phone = val);
                  },

                 ),
                
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                      child: Text('Register Phone', 
                      style: TextStyle(color: Colors.white),
                      ),
                     onPressed: () async {
                       print(phone);
                     },
                    ),

                        SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                      child: Text('Email Sign Up', 
                      style: TextStyle(color: Colors.white),
                      ),
                     onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Register()),
  );

                     },
                    ),
                  
                   

              ]

            ),
            
            
            ),
        ),
      );
  }
}