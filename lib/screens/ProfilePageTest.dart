import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AccountSetting.dart';
import 'RegisterationForm.dart';

class ProfileOkPage extends StatefulWidget {
  @override
  ProfileOkPageState createState() => ProfileOkPageState();
}

class ProfileOkPageState extends State<ProfileOkPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int position = 0;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
    getPerson();
    _tabController.addListener(_handleTabSelection);
  }

  DocumentSnapshot _snapshot;

  getPerson() async {
    var preferences = await SharedPreferences.getInstance();

    var a = preferences.getString("UserId");
    if (a != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(a)
          .get()
          .then((value) {
        print(value.id.toString());
        print(value.data()['image']);
        setState(() {
          _snapshot = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var a = Provider.of<UserModel>(context).uid;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: _snapshot != null
              ? NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        centerTitle: true,
                        title: Text(
                          '@David66050807',
                          style: TextStyle(fontSize: 15),
                        ),
                        expandedHeight: 280.0,
                        automaticallyImplyLeading: false,
                        pinned: true,
                        bottom: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.orange,
                          onTap: (index) {
                            setState(() {
                              position = index;
                            });
                          },
                          tabs: [
                            Tab(
                              child: Text(
                                "Published",
                                style: TextStyle(
                                    color: position == 0
                                        ? Colors.orange
                                        : Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Private",
                                style: TextStyle(
                                    color: position == 1
                                        ? Colors.orange
                                        : Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Liked",
                                style: TextStyle(
                                    color: position == 2
                                        ? Colors.orange
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: SafeArea(
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 125,
                                    color: Colors.black,
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(_snapshot
                                                      .data()["image"]),
                                                ),
                                                color: Colors.grey,
                                              ),
                                              // child: CachedNetworkImage(
                                              //   imageUrl:
                                              //       _snapshot.data()['image'],
                                              //   placeholder: (context, url) =>
                                              //       new CircularProgressIndicator(),
                                              //   errorWidget:
                                              //       (context, url, error) =>
                                              //           new Icon(Icons.error),
                                              // ),
                                              height: 85,
                                            ),
                                            Container(
                                              height: 40,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          top: 50.0,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      _snapshot
                                                          .data()["image"]),
                                                  maxRadius: 35.0,
                                                  // child: CachedNetworkImage(
                                                  //   imageUrl: _snapshot
                                                  //       .data()["image"],
                                                  //   placeholder: (context,
                                                  //           url) =>
                                                  //       new CircularProgressIndicator(),
                                                  //   errorWidget: (context, url,
                                                  //           error) =>
                                                  //       new Icon(Icons.error),
                                                  // ),
                                                ),
                                                _container(
                                                    int.parse(_snapshot
                                                        .data()["videos"]),
                                                    "Videos"),
                                                _container(
                                                    int.parse(_snapshot
                                                        .data()["follower"]),
                                                    "Followers"),
                                                _container(
                                                    int.parse(_snapshot
                                                        .data()["following"]),
                                                    "Following"),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10.0),
                                      Text(
                                        _snapshot.data()["name"],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                      height: 50,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  maxRadius: 25,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/Facebook.png"),
                                                ),
                                                Positioned(
                                                  right: 0.0,
                                                  child: Icon(
                                                    Icons.cancel,
                                                    size: 17.0,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  maxRadius: 25,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/Facebook.png"),
                                                ),
                                                Positioned(
                                                  right: 0.0,
                                                  child: Icon(
                                                    Icons.cancel,
                                                    size: 17.0,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  maxRadius: 25,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/Facebook.png"),
                                                ),
                                                Positioned(
                                                  right: 0.0,
                                                  child: Icon(
                                                    Icons.cancel,
                                                    size: 17.0,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 25,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/Facebook.png"),
                                                ),
                                                Positioned(
                                                  right: 0.0,
                                                  child: Icon(
                                                    Icons.cancel,
                                                    size: 17.0,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlineButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Text("Edit Profile"),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationForm()));
                                        },
                                      ),
                                      SizedBox(width: 10.0),
                                      InkWell(
                                        onTap: () {},
                                        splashColor: Colors.grey,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Transform.rotate(
                                                angle: 180 * pi / 180,
                                                child: Icon(
                                                  Icons.reply_outlined,
                                                  color: Colors.orange,
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AccountSetting(_snapshot)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 50,
                            backgroundImage:
                                AssetImage("assets/images/emptycart.png"),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "No Videos Found!",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "May go back and try \n\t\tsomething else?",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.directions_transit),
                      Icon(Icons.directions_bike),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        )
        // ],
        );
  }

  _container(int number, String text) {
    return Container(
      height: 55,
      // width: MediaQuery.of(context).size.width / 4 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              number.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }

  _handleTabSelection() {
    setState(() {
      position = _tabController.index;
    });
  }
}
