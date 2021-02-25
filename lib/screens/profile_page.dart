import 'package:broadcastr_ui/auth/register.dart';
import 'package:broadcastr_ui/screens/phone_register.dart';
import 'package:flutter/material.dart';
import '../tik_tok_icons_icons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
       appBar:
        AppBar(
        title: Padding(
          padding: EdgeInsets.only(left:130.0),
          child: Text('Profile', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),                             
       backgroundColor: Colors.white,),

      body: SafeArea(
        
        child: Padding(
          padding: EdgeInsets.only(top:150.0, left: 100.0), 
          child: Column(

            children: <Widget> [ 
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(TikTokIcons.profile, size: 100.0),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sign Up for an Account'),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
               onPressed: () => {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PhoneRegister()),
  )
            },
            child: new Text('Sign Up'),
          ),
              ),
            ]
            
            
                ),
        ),
            )
      );
        
  }
    }


