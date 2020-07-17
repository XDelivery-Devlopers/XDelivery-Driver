import 'package:edelivery_driver/router/screens_argument.dart';
import 'package:edelivery_driver/utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';

class AddPhoneScreen extends StatefulWidget {
  @override
  _AddPhoneScreenState createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  bool btnEnabled;
  String dialcode;
  TextEditingController phoneInputController;
  @override
  void initState() {
    phoneInputController = TextEditingController();
    dialcode = '+251';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Enter Phone Number',
                      style: TextStyle(fontSize: 20))),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  CountryCodePicker(
                    initialSelection: 'ET',
                    onChanged: (code) {
                      setState(() {
                        dialcode = code.dialCode;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onSubmitted: null,
                      controller: phoneInputController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Phone number',
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {
                        if (val.length == 7) {
                          setState(() {
                            btnEnabled = true;
                          });
                        } else {
                          setState(() {
                            btnEnabled = false;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
              Divider(
                height: 10,
                thickness: 1,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text.rich(
                    TextSpan(
                        text:
                            'By continuing, I confirm that i have read & agree to the ',
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // code to open / launch terms of service link here
                                }),
                          TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black45),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // code to open / launch privacy policy link here
                                      })
                              ])
                        ]),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ButtonTheme(
                  minWidth: 340,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () => {
                      btnEnabled == false ? null : print(''),
                      Navigator.pushNamed(context, otpverifyRoute,
                          arguments: ScreenArguments(
                              dialcode + phoneInputController.text))
                    },
                    shape: StadiumBorder(),
                    textColor: Colors.white,
                    color: Colors.black,
                    disabledColor: btnEnabled == false ? Colors.blueGrey : null,
                    child: Text('Continue'),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
