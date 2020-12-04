import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/Conversation_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchList extends StatefulWidget {
  final TextEditingController searchController;
  const SearchList({Key key, this.searchController}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  DateTime lastChange = DateTime.now();

  @override
  void initState() {
    widget.searchController.addListener(() {
      if (this.mounted)
        this.setState(() {
          print('updating list');
        });

      lastChange = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchController.text.isEmpty)
      return StreamBuilder<QuerySnapshot>(
        stream: DatabaseMethods().getUsersList(),
        builder: (_, snap) {
          if (snap.hasData) {
            final userList = snap.data.docs
              ..removeWhere((e) =>
                  AuthMehtods().user.displayName.compareTo(e.data()['name']) ==
                  0);

            return ListView(
              children: userList.map((e) {
                return userTile(e.data());
              }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    return FutureBuilder<Map<String, dynamic>>(
        future:
            DatabaseMethods().getUserByUsername(widget.searchController.text),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData &&
              snapshot.data['name'] != AuthMehtods().user.displayName) {
            return ListView(
              children: [
                userTile(snapshot.data),
              ],
            );
          }
          return snapshot.connectionState == ConnectionState.done
              ? Container()
              : Center(child: CircularProgressIndicator());
        });
  }

  //
  //
  //

  Widget userTile(Map<String, dynamic> user) {
    double sHeight = Get.height;
    double swidth = Get.width;
    return Column(
      children: [
        InkWell(
          onTap: () => Get.to(ConversationScreen(), arguments: user),
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
                              user["name"],
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
                              padding: const EdgeInsets.only(right: 15.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}
