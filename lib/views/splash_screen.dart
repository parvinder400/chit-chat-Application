import 'package:chatapp/views/chat-room-screen.dart';

import 'package:chatapp/Model/widget.dart';
import 'package:chatapp/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  Future<bool> isSignedIn() async {
    print('b4 init app');
    await Firebase.initializeApp();
    print('after init');
    final user = await FirebaseAuth.instance.authStateChanges().first;
    await Future.delayed(Duration(seconds: 1));
    return user == null;
  }

  @override
  Widget build(BuildContext context) {
    final sheight = Get.height;

    return FutureBuilder<bool>(
      future: isSignedIn(),
      builder: (_, snap) {
        if (snap.hasData) {
          bool visible = false;
          return FutureBuilder(
              future: Future.delayed(
                  Duration(microseconds: 20), () => visible = true),
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  opacity: visible ? 1.0 : 0.2,
                  child: snap.data ? SignIn() : ChatRoom(),
                );
              });
        }
        return Scaffold(
          body: containerWithBackground(
            assetUrl: 'assets/images/Splashscreen.jpg',
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: sheight / 4,
                  ),
                  Text(
                    'Getting you ready...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: sheight / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: Text(
                      'Chit Chat App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: Text(
                      'From',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: Text(
                      'P A R V I N D E R',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 200),
            // child: Text(
            //   'Getting you ready...',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
