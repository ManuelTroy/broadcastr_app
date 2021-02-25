import 'package:broadcastr_ui/models/user.dart';
import 'package:broadcastr_ui/screens/inbox_page.dart';
import 'package:broadcastr_ui/screens/profile_page.dart';
import 'package:broadcastr_ui/screens/search_page.dart';
import 'package:broadcastr_ui/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:broadcastr_ui/homescreen.dart';
import 'package:broadcastr_ui/tik_tok_icons_icons.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

 // main.dart text theme update
Widget build(BuildContext context) {
  
  return StreamProvider<User>.value(
     value: AuthService().user,
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Uncomment in phase 3 to apply white to text
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black
        ),
        primaryColor: Colors.black,
        accentColor: Color(0xFFD8ECF1)
      ),
      debugShowCheckedModeBanner: false,
           home: MyNavigationBar(),  
      ),
  );
   
  }

}
 
class MyNavigationBar extends StatefulWidget {  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  

class _MyNavigationBarState extends State<MyNavigationBar > {  

  int _currentIndex = 0;  

  final tabs = [
  HomeScreen(),
  SearchPage(),
  Center(child: Text('Create')),
  InboxPage(),
  ProfilePage(),
  ];

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: tabs [_currentIndex], 
      bottomNavigationBar: BottomNavigationBar (
        currentIndex: _currentIndex,
        items: [  
          BottomNavigationBarItem(
            icon: Icon(
              TikTokIcons.home,
              size: 20.0,
            ),
            title: Text('Home'),
            backgroundColor: Colors.black,
          
          ),
          BottomNavigationBarItem(
            icon: Icon(
               TikTokIcons.search,
              size: 20.0,
            ), 
            title:  Text('Search')),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.stream,
              size: 30.0,
            ),
            title: Text('Create')),

          
             BottomNavigationBarItem(
            icon: Icon(
              TikTokIcons.messages,
              size: 20.0,
            ),
            title: Text('inbox')),
          
          BottomNavigationBarItem(
           icon: Icon(
              TikTokIcons.profile,
              size: 20.0,
            ),
            title:  Text('Me'),
          ),
        ],  
       onTap: (index) {
         setState(() {
           _currentIndex = index;
         });
       },
       type: BottomNavigationBarType.fixed,
    ),  
    );  
  }  
}  



