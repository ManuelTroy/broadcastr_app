import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../NavigatorBar.dart';

class RegistrationForm extends StatefulWidget {
  String PhoneNumber = '', email = '', password = '', uid;
  RegistrationForm({this.PhoneNumber, this.email, this.password, this.uid});
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  File imageFile;

  String name,
      password = '',
      phoneNumber = "",
      email = "",
      facebook = "",
      instagram = "",
      youTube = "",
      twitter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Profile Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    padding: const EdgeInsets.all(5.0),
                    child: imageFile == null
                        ? Text("Profile Photo")
                        : Image.file(imageFile),
                  ),
                  Divider(),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: pickerCamera,
                  ),
                  Divider(),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: pickerGalllery,
                  )
                ],
              ),
              SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter the Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Name"),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
              if (widget.email.length <= 0)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
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
                    decoration: InputDecoration(hintText: "Email"),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
              if (widget.password.length <= 0)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter the password";
                      } else if (value.length < 6) {
                        return 'Enter a password 6+ chars long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
              if (widget.PhoneNumber.length <= 0)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Mobile Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: "Mobile Number"),
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Facebook Link"),
                  onChanged: (value) {
                    setState(() {
                      facebook = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "YouTube"),
                  onChanged: (value) {
                    setState(() {
                      youTube = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Twitter"),
                  onChanged: (value) {
                    setState(() {
                      twitter = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Instagram"),
                  onChanged: (value) {
                    setState(() {
                      instagram = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: Submit,
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.orange,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  pickerCamera() async {
    PickedFile img =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (img != null) {
      imageFile = File(img.path);
      setState(() {});
    }
  }

  pickerGalllery() async {
    PickedFile img =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (img != null) {
      imageFile = File(img.path);
      setState(() {});
    }
  }

  void createData() async {
    DateTime now = DateTime.now();

    String nameformate = DateFormat('kk:mm:ss:MMMd').format(now);
    var fullImageName = 'ImageName-$nameformate' + '.jpg';

    final Reference ref =
        FirebaseStorage.instance.ref().child("Images/$fullImageName");
    // final StorageUploadTask task = ref.putFile(image);

    UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.then((value) {
      print('File Uploaded' + "$value");
    });

    String fullPathImage;
    await ref.getDownloadURL().then((fileURL) {
      fullPathImage = fileURL;
      print('url done.\n $fullPathImage');
    });

    //firebaseurl of image gose here
    var map = Map<String, dynamic>();

    print(fullPathImage);
    if (widget.PhoneNumber.length <= 0 || widget.email.length > 0) {
      map['mobileNumber'] = phoneNumber;
      map['email'] = widget.email;
      map['password'] = widget.password;
    } else {
      map['mobileNumber'] = widget.PhoneNumber;
      map['email'] = email;
      map['password'] = password;
    }

    map['name'] = '$name';
    map['facebook'] = '$facebook';
    map['instagram'] = '$instagram';
    map['youtube'] = '$youTube';
    map['twitter'] = '$twitter';
    map["follower"] = '0';
    map['videos'] = '0';
    map['following'] = '0';
    map['image'] = '$fullPathImage';

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.uid)
        .set(map)
        .then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyNavigationBar(index: 4)));
    }).catchError((onError) {});
  }

  void Submit() {
    _dialog(context);
    var check = _formKey.currentState.validate();
    if (check) {
      _formKey.currentState.save();
      if (imageFile != null) {
        createData();
      } else {
        Navigator.of(context).pop();

        print("Please Take a Picture");
      }
    } else {
      Navigator.of(context).pop();
      print("fill name");
    }
  }

  _dialog(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
