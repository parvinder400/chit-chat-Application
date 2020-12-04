import 'package:chatapp/Model/demo_localiztion.dart';
import 'package:chatapp/Model/language.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/views/chat-room-screen.dart';

import 'package:chatapp/views/signup.dart';
import 'package:chatapp/Model/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

String name, email, photourl;

class SignIn extends StatefulWidget {
  static String id = 'signin';
  final auth = AuthMehtods();

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SignIn> {
  static TextEditingController emController = TextEditingController();
  static TextEditingController passController = TextEditingController();

  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'hi':
        _temp = Locale(language.languageCode, 'IN');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
  }

  final formKey = GlobalKey<FormState>();
  bool processing = false;

  void signMeIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        processing = true;
      });
      widget.auth
          .signInWithEmailAndPassword(emController.text, passController.text)
          .then((value) {
        setState(() {
          processing = false;
        });
        _clearControllers();
        Get.off(ChatRoom());
      }).catchError(
        (e) {
          debugPrint('ERROR: $e');
          setState(() {
            processing = false;
          });
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  'Signin Failed!',
                ),
                content: Text(
                  'Incorrect email or password, try again.',
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text('OK'),
                    isDestructiveAction: true,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  void _clearControllers() {
    emController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // final double sWidth = MediaQuery.of(context).size.width;
    final double sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios),
          //   onPressed: () => Get.off(LanguageScreen()),
          // ),
          // automaticallyImplyLeading: false,
          actions: [
            DropdownButton(
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                          value: lang,
                          child: Row(
                            children: <Widget>[
                              Text(lang.name),
                              Text(lang.flag),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (Language language) {
                  _changeLanguage(language);
                }),
          ],
          title: Text(
            DemoLocalization.of(context).getTranslatedValues('welcomeSignin'),
          ),
          // title: Text('Welcome! Please Sign in'),
          backgroundColor: Colors.black12,
        ),
        body: containerWithBackground(
          assetUrl: 'assets/images/greenbg.jpg',
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                SizedBox(
                  height: sHeight / 3,
                ),
                EntryBoxConst(
                  hinttext: DemoLocalization.of(context)
                      .getTranslatedValues('emailHint'),
                  keyboardType: TextInputType.emailAddress,
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
                  hinttext: DemoLocalization.of(context)
                      .getTranslatedValues('PassHint'),
                  icon: FontAwesomeIcons.key,
                  obscureText: true,
                  textController: passController,
                  validator: (value) => value.length >= 8
                      ? null
                      : DemoLocalization.of(context)
                          .getTranslatedValues('validpass'),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    // child: Text(
                    //   'Forget Password?',
                    //   style: TextStyle(
                    //     fontStyle: FontStyle.italic,
                    //     fontSize: 15,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                ),
                (processing == true)
                    ? BtnConst(
                        text: 'wait',
                        bdcolor: Colors.blue,
                        onPressed: () => null)
                    : BtnConst(
                        text: DemoLocalization.of(context)
                            .getTranslatedValues('SignIn'),
                        onPressed: signMeIn,
                      ),
                // BtnConst(
                //   text: 'Sign in',
                //   onPressed: signMeIn,
                // ),
                BtnConst(
                  text: DemoLocalization.of(context)
                      .getTranslatedValues('SignInwithgoolge'),
                  onPressed: () => print('Sign in with Google tap'),
                  btnicon: FontAwesomeIcons.google,
                ),
                BottomNavText(
                  text1: DemoLocalization.of(context)
                      .getTranslatedValues('DontHaveAccount'),
                  text2: DemoLocalization.of(context)
                      .getTranslatedValues('Registernow'),
                  onTap: () => Get.to(SignUp()),
                ),
              ],
            ),
          ),
        ));
  }
}
