import 'package:chatapp/Model/widget.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/views/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForthIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sheight = Get.height;

    final sWidth = Get.width;
    return Scaffold(
      body: containerWithBackground(
        assetUrl: 'assets/images/intro4.jpg',
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: sheight / 3,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                height: sheight / 3.2,
                width: sWidth / 1.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Icon(
                      IconData(59692, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'No Limits',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'You can use our generator without any limitations, our generator allows to generate unlimited diamonds.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sWidth / 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawMaterialButton(
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Text(
                      'Ready',
                      style: TextStyle(
                          color: Colors.white,
                          // fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    RawMaterialButton(
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                      onPressed: () async {
                        await setvisitingflag();
                        await Get.offAll(SplashScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
