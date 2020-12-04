import 'package:chatapp/Model/demo_localiztion.dart';
import 'package:chatapp/Model/language.dart';
import 'package:chatapp/services/auth.dart';

import 'package:chatapp/views/Conversation_Screen.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/views/searh_list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class ChatRoom extends StatefulWidget {
  static String id = 'chat-room-screen';

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  bool _isSearching = false;
  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    // var user = new Map();
    // user['email'] = 'demo@gmail.com';
    // user['name'] = 'demouser';

    final double sHeight = MediaQuery.of(context).size.height;
    final double swidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF2a2f32),
      appBar: _isSearching == true
          ? AppBar(
              backgroundColor: Color(0xFF2a2f32),
              centerTitle: false,
              title: TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(
                        () {
                          searchController.clear();
                          _isSearching = false;
                        },
                      );
                    },
                  ),
                  fillColor: Colors.white,
                ),
              ),
            )
          : AppBar(
              backgroundColor: Color(0xFF2a2f32),
              centerTitle: false,
              title: Text(
                  DemoLocalization.of(context).getTranslatedValues('ChatApp')
                  // style: TextStyle(
                  //   fontSize: 20.0,
                  // ),
                  ),
              // leading: IconButton(
              //     icon: Icon(
              //       Icons.list,
              //     ),
              //     onPressed: () {}),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _isSearching = true;
                      },
                    );
                  },
                ),
                PopupMenuButton(
                  color: Color(0xFF2a2f38),
                  icon: Icon(
                    Icons.more_vert,
                  ),

                  // elevation: 4.0,
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                          child: Center(
                        child: Text(
                          'Setting',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      PopupMenuItem(
                        child: GestureDetector(
                          child: Center(
                            child: Text(
                              'LogOut',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            if (GetPlatform.isIOS) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return Theme(
                                    data: ThemeData.dark(),
                                    child: CupertinoAlertDialog(
                                      title: Text(
                                        'Log out',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        'Are you sure You Want to Log Out ?',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Log Out',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          isDefaultAction: true,
                                          onPressed: () {
                                            AuthMehtods().signOut();
                                            Get.offAll(SignIn());
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            if (GetPlatform.isAndroid) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFF2a2f32),
                                    title: Text(
                                      "Log Out",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'Are you sure You Want to Log Out ?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Log Out',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          AuthMehtods().signOut();
                                          return Get.offAll(SignIn());
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ];
                  },
                ),
                DropdownButton(
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                            (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        lang.name,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Text(lang.flag),
                                    ],
                                  ),
                                ))
                        .toList(),
                    onChanged: (Language language) {
                      _changeLanguage(language);
                    }),
              ],
            ),
      body: _isSearching == true
          ? SearchList(searchController: searchController)
          : ListView(
              children: [
                InkWell(
                  onTap: () => Get.to(
                    ConversationScreen(),
                    arguments: Map.of({'name': 'Demo'}), //format entry
                  ),
                  splashColor: Colors.cyan,
                  // highlightColor: Colors.green[500],
                  child: Container(
                    height: sHeight / 10,
                    // color: Colors.pink,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 30.0,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'DemoUser Field',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        'Time',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'New Msg',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 2.0,
                  color: Colors.black,
                  indent: swidth / 6,
                  endIndent: 20,
                ),
              ],
            ),
      drawer: Drawer(
        child: (ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              children: [
                new Container(
                  color: Color(0xFF2a2f32),
                  padding: EdgeInsets.only(top: 30),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF2a2f32),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Text(
                        AuthMehtods().user.displayName.characters.first,
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                    accountName: Text(
                      AuthMehtods().user.displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    accountEmail: Text(
                      AuthMehtods().user.email,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: sHeight,
                      color: Color(0xFF2a2f32),
                      child: Column(
                        children: [
                          // Divider(
                          //   color: Colors.white,
                          //   endIndent: 20.0,
                          //   indent: 20.0,s
                          // ),
                          ListTile(
                            title: Text(
                              'New Chat',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _isSearching = true;
                              });
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Archive Messages',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
