
import 'package:broadcastr_ui/homescreen.dart';
import 'package:broadcastr_ui/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:broadcastr_ui/tik_tok_icons_icons.dart';

class BottomToolbar2 extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 34.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton (
                icon: Icon(TikTokIcons.home),
                    color: Colors.black, 
                    iconSize: NavigationIconSize, 
                    onPressed: () { Navigator.push (
                      context,
       MaterialPageRoute(builder: (context) => HomeScreen()),);
       
                    }),
       
       
                 
                IconButton (
                icon: Icon(TikTokIcons.search),
                    color: Colors.black, 
                    iconSize: NavigationIconSize, 
                    onPressed: () { Navigator.push( 
                      context,
       MaterialPageRoute(builder: (context) => SearchPage()),
  );   }),
                  
                    customCreateIcon,
                Icon(TikTokIcons.messages,
                    color: Colors.black, size: NavigationIconSize),
                Icon(TikTokIcons.profile,
                    color: Colors.black, size: NavigationIconSize)
              ,
       ] );
    
  }
  Widget get customCreateIcon => Container(
          width: 45.0, 
          height: 27.0,
          child: Stack(
            children:[
              Container(
                margin: EdgeInsets.only(left: 10.0),
                width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0)
              )),
              
              Container(
                margin: EdgeInsets.only(right: 10.0),
                width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0)
              )),
              Center(child:Container(
                height: double.infinity,
                width: CreateButtonWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.0)
              ),
              child: Icon(Icons.add, size: 20.0,),
              )),
              ]
          ));

}
