import 'package:broadcastr_ui/auth/register.dart';
import 'package:broadcastr_ui/services/auth.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class PhoneRegister extends StatefulWidget {
  bool checkSignIn;
  PhoneRegister(this.checkSignIn);

  @override
  _PhoneRegisterState createState() => _PhoneRegisterState();
}

class _PhoneRegisterState extends State<PhoneRegister> {
  final AuthService _auth = AuthService();

  // text field state
  String phone = '';

  TextEditingController _phoneNumberController;

  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  String countryCode = '+92';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.checkSignIn ? 'Phone Sign In' : 'Phone Sign Up'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                // TextFormField(
                //   decoration: InputDecoration(hintText: 'Enter Phone Number'),
                //   onChanged: (val) {
                //     setState(() => phone = val);
                //   },
                // ),
                Row(
                  children: [
                    Container(
                      width: 90,
                      child: CountryListPick(
                        pickerBuilder: (context, CountryCode countryCode) {
                          return Row(
                            children: [
                              Image.asset(
                                countryCode.flagUri,
                                package: 'country_list_pick',
                                height: 20,
                                width: 20,
                              ),
                              Text(countryCode.code),
                              Text(countryCode.dialCode),
                            ],
                          );
                        },

                        // To disable option set to false
                        theme: CountryTheme(
                          isShowFlag: true,
                          isShowTitle: true,
                          isShowCode: true,
                          isDownIcon: true,
                          showEnglishName: true,
                        ),
                        initialSelection: countryCode,
                        onChanged: (CountryCode code) {
                          countryCode = code.dialCode;
                          setState(() {});
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneNumberController,
                          onChanged: (text) {},
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                            prefixStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                            ),
                          ),
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Please enter mobile number';
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                    widget.checkSignIn ? 'LogIn' : 'Register Phone',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print(phone);
                    if (_formKey.currentState.validate()) {
                      print(countryCode + _phoneNumberController.text);
                      String phoneNumber =
                          countryCode + _phoneNumberController.text;
                      String phone = "0" + _phoneNumberController.text;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => OTPScreen(
                                phone: phone,
                                mobileNumber: phoneNumber,
                                checkSignIn: widget.checkSignIn,
                              )));
                    }
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                    widget.checkSignIn ? 'Email Sign In' : 'Email Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register(widget.checkSignIn)),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
