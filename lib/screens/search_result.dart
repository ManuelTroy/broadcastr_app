import 'package:broadcastr_ui/homescreen.dart';
import 'package:broadcastr_ui/screens/search_page.dart';
import 'package:flutter/material.dart';


   class SearchResult extends StatefulWidget {
     @override
     _SearchResultState createState() => _SearchResultState();
   }
   
   class _SearchResultState extends State<SearchResult> {
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
                  hintText: "Search here...",
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
                bottom: TabBar(  
              tabs: [  
                Tab( text: "USERS"),  
                Tab( text: "SOUNDS"),
                Tab( text: "VIDEOS"),
                Tab( text: "HASHTAGS")      
              ], 
          )
     ),
body: TabBarView(  
            children: [  
             Center(child: Text('USERS')),
               Center(child: Text('MOVE')),
                Center(child: Text('VIDEOS')),
              Center(child: Text('HASHTAG')),
            ],  
          ),  
        )));
  
     }
   }

   