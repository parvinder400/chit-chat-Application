// import 'package:chatapp/Model/demo_localiztion.dart';
// import 'package:chatapp/Model/language.dart';
// import 'package:chatapp/Model/widget.dart';
// import 'package:chatapp/views/signin.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/cupertino.dart';

// import '../main.dart';

// class LanguageScreen extends StatefulWidget {
//   @override
//   _LanguageScreenState createState() => _LanguageScreenState();
// }

// class _LanguageScreenState extends State<LanguageScreen> {
//   final sheight = Get.height;

//   final sWidth = Get.width;

//   void _changeLanguage(Language language) {
//     Locale _temp;
//     switch (language.languageCode) {
//       case 'en':
//         _temp = Locale(language.languageCode, 'US');
//         break;
//       case 'hi':
//         _temp = Locale(language.languageCode, 'IN');
//         break;
//       default:
//         _temp = Locale(language.languageCode, 'US');
//     }
//     MyApp.setLocale(context, _temp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: containerWithBackground(
//         assetUrl: 'assets/images/Splashscreen.jpg',
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: sheight / 4,
//               ),
//               Text(
//                 'Select The Language',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 40.0,
//               ),
//               Container(
//                 // alignment: Alignment.center,
//                 height: 50,
//                 width: sWidth / 2,
//                 color: Colors.black54,
//                 child: DropdownButton(
//                     items: Language.languageList()
//                         .map<DropdownMenuItem<Language>>(
//                             (lang) => DropdownMenuItem(
//                                   value: lang,
//                                   child: Row(
//                                     children: <Widget>[
//                                       Text(lang.name),
//                                       Text(lang.flag),
//                                     ],
//                                   ),
//                                 ))
//                         .toList(),
//                     onChanged: (Language language) {
//                       _changeLanguage(language);
//                     }),

//                 //     CupertinoPicker(
//                 //   itemExtent: 32.0,
//                 //   // onSelectedItemChanged: (language) {
//                 //   //   _changeLanguage(language);
//                 //   },
//                 //   children: [
//                 //     Text(
//                 //       'Select Language',
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //       ),
//                 //     ),
//                 //     Text(
//                 //       'English',
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //       ),
//                 //     ),
//                 //     Text(
//                 //       'Hindi',
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//               ),
//               SizedBox(
//                 height: sheight / 4,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 100.0, right: 100.0),
//                 child: FlatButton(
//                   onPressed: () {
//                     Get.to(SignIn());
//                   },
//                   color: Colors.green[800],
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     // Replace with a Row for horizontal icon + text
//                     children: <Widget>[
//                       Text(
//                         DemoLocalization.of(context)
//                             .getTranslatedValues("Continue"),
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
