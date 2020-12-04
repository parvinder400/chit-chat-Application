import 'package:chatapp/Model/demo_localiztion.dart';
import 'package:chatapp/views/intro_screen/firstIntro.dart';
import 'package:chatapp/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: _locale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      home: FutureBuilder<bool>(
          future: getvisitingflag(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return SplashScreen();
              }
            }
            return FirstIntro(); //resetvisitingflag();
          }),

      //home: FirstIntro(),
      // home: SplashScreen(),
    );
  }
}

setvisitingflag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setBool('alreadyvisited', true);
}

Future<bool> getvisitingflag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getBool('alreadyvisited'));
  bool alreadyvisited = preferences.getBool('alreadyvisited') ?? false;
  return alreadyvisited;
}

//  await resetvisitingflag();
// resetvisitingflag() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.remove('alreadyvisited');
// }
