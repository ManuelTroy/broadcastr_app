import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
     @override
     _SearchBarState createState() => _SearchBarState();
   }
   
   class _SearchBarState extends State<SearchBar> {
     @override
     Widget build(BuildContext context) {

     return MaterialApp(  
       debugShowCheckedModeBanner: false,
      home: DefaultTabController(  
        length: 4,  
        child: Scaffold(
          appBar: AppBar (
      backgroundColor: Colors.red[300],
      title: Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      decoration: BoxDecoration(
       color: Color.fromARGB(50, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                ),
                    child: Row (
                crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                       Expanded(
                     flex: 1,
                       child: Container (
                       padding: EdgeInsets.symmetric(horizontal: 8.0),
                   child: TextFormField(
                  decoration: InputDecoration(
                 border: InputBorder.none,
                  hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white ),
                 
                     icon: Icon(Icons.search, color: Colors.white),
                     ),
                        ),
                             ),
                         ),

                   Expanded (
                   flex: 0,
                child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 5.0),
                   child: Row(
                     children: <Widget>[
                     IconButton(
                 onPressed: () {},
                    icon: Icon(Icons.more_vert, color: Colors.white),
         ),
         ],
      ),
    ),
   ),
  ],
      ),
 ),
              
              

     ),

        )));
  
     }
   }

   