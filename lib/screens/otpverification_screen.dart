import 'dart:async';
import 'package:edelivery_driver/utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  OtpVerificationScreen({this.phoneNumber});
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var otpController = TextEditingController();
  String _verificationId;
  String otpValue;


  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          var result = await _auth.signInWithCredential(credential);
          var user = result.user;
          if (user != null) {
            await Navigator.pushNamed(context, homeRoute);
          } else {
            print('Error erorrrrrr');
          }
        },
        verificationFailed: print,
        codeSent: (String verificationId, [int forceResendingToken]) async {
          _verificationId = verificationId;
          print('$verificationId is verification');
          setState(
                () {
              _verificationId = verificationId;
            },
          );
        },
        codeAutoRetrievalTimeout: null);
  }

    void signInWithPhoneNumber() async {
      var _authCredential = PhoneAuthProvider.getCredential(
          verificationId: _verificationId, smsCode: otpValue);
      var result = await _auth.signInWithCredential(_authCredential);

      var user = result.user;

      if (user != null) {
        await Navigator.pushNamed(context, homeRoute);
      } else {
        print('Error');
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Text('OTP Verification',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter the 4-digit code sent to you at',
                  style: TextStyle(fontSize: 14, color: Colors.black45),
                )),
            SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text.rich(
                TextSpan(
                    text: widget.phoneNumber,
                    children: <TextSpan>[
                      TextSpan(
                          text: '  Edit',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff3369FF)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                             Navigator.pop(context);
                              // code to open / launch terms of service link here
                            }),
                    ],
                    style: TextStyle(
                      fontSize: 14,
                    )),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            PinCodeTextField(
              controller: otpController,
              autoFocus: true,
              length: 6,
              obsecureText: false,
              animationType: AnimationType.slide,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //controller: otpController,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
               // borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveColor: Colors.blueGrey
              ),
              animationDuration: Duration(milliseconds: 300),
              onCompleted: (value) {
                setState(() {
                    otpValue = value;
                //  phone = widget.phonenumber;
                });
              },
              onChanged: null,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ButtonTheme(
                minWidth: 340,
                height: 40,
                child: RaisedButton(
                  onPressed: signInWithPhoneNumber,
                  shape: StadiumBorder(),
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('SUBMIT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
