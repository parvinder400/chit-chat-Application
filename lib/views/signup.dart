import 'package:chatapp/Model/demo_localiztion.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/Model/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  static String id = 'signup';
  final auth = AuthMehtods();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emController = TextEditingController();
  static TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool processing = false;

  void _clearControllers() {
    emController.clear();
    passController.clear();
    nameController.clear();
  }

  void signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        processing = true;
      });

      widget.auth
          .signInWithEmailAndPassword(
        emController.text,
        passController.text,
        username: nameController.text,
        newUser: true,
      )
          .then((user) async {
        // await DatabaseMethods().uploadUserInfo(user.uid, userinfoMap);
        setState(() {
          processing = false;
        });

        _clearControllers();
        if (GetPlatform.isIOS) {
          showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text(
                    'Registration Sucessfull',
                  ),
                  content: Text(
                    'Thanks For Registering , you can Signin now',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('OK'),
                      isDestructiveAction: true,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Go to Login'),
                      isDefaultAction: true,
                      onPressed: () {
                        Get.offAll(SignIn());
                      },
                    )
                  ],
                );
              });
        }
        if (GetPlatform.isAndroid) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Color(0xFF2a2f32),
                title: Text(
                  "Registration Successfull",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'Thanks For Registering , you can Signin now',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'ok',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Go to Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.offAll(SignIn());
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.offAll(SignIn()),
        ),
        title: Text(
          DemoLocalization.of(context).getTranslatedValues('Registernow'),
        ),
        backgroundColor: Colors.black12,
        centerTitle: false,
      ),
      body: containerWithBackground(
        assetUrl: 'assets/images/pink.jpg',
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              SizedBox(
                height: sHeight / 4,
              ),
              EntryBoxConst(
                hinttext: DemoLocalization.of(context)
                    .getTranslatedValues('userHint'),
                validator: (value) {
                  return value.isEmpty || value.length < 4
                      // RegExp(r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$")
                      //     .hasMatch(value)
                      ? DemoLocalization.of(context)
                          .getTranslatedValues('validuser')
                      : null;
                },
                icon: FontAwesomeIcons.user,
                textController: nameController,
              ),
              SizedBox(
                height: 15.0,
              ),
              EntryBoxConst(
                keyboardType: TextInputType.emailAddress,
                hinttext: DemoLocalization.of(context)
                    .getTranslatedValues('emailHint'),
                icon: Icons.email,
                textController: emController,
                validator: (value) =>
                    RegExp(r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$")
                            .hasMatch(value)
                        ? null
                        : DemoLocalization.of(context)
                            .getTranslatedValues('validemail'),
              ),
              SizedBox(
                height: 15.0,
              ),
              EntryBoxConst(
                icon: FontAwesomeIcons.key,
                hinttext: DemoLocalization.of(context)
                    .getTranslatedValues('PassHint'),
                textController: passController,
                validator: (value) => value.length >= 8
                    ? null
                    : DemoLocalization.of(context)
                        .getTranslatedValues('validpass'),
                obscureText: true,
              ),
              SizedBox(
                height: 15.0,
              ),
              if (processing == false)
                BtnConst(
                  text: DemoLocalization.of(context)
                      .getTranslatedValues('signup'),
                  onPressed: signMeUp,
                )
              else
                BtnConst(
                  text: 'Wait',
                  bdcolor: Colors.blue,
                  onPressed: () => null,
                ),
              BtnConst(
                  text: DemoLocalization.of(context)
                      .getTranslatedValues('SignInwithgoolge'),
                  btnicon: FontAwesomeIcons.google,
                  onPressed: () => _googleSignIn()),
              BottomNavText(
                text1: DemoLocalization.of(context)
                    .getTranslatedValues('alreadyhaveaccout'),
                text2:
                    DemoLocalization.of(context).getTranslatedValues('SignIn'),
                onTap: () => Get.offAll(SignIn()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _googleSignIn() async {
    try {
      final res = await AuthMehtods().signInWithGoogle();
      if (res != null) Get.to(SignIn());
    } catch (e) {
      print(e);
    }
  }
}
