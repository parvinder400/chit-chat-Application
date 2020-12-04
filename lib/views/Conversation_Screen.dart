import 'package:chatapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationScreen extends StatefulWidget {
  // String chatRoomId;

  // ConversationScreen(this.chatRoomId);
  static String id = 'conversation_screens';
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final messageTextController = TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  String messageTyped;

  // sendMessage() {
  //   if (messageControler.text.isNotEmpity) {
  //     Map<String, String> messageMap = {"message": messageController.text,
  //     "sendBy": Constants.myName};
  //   }
  //  databaseMethods.getConversationMessages((widget.chatRoomId.messageMap);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Get.arguments;
    print(user);

    return Scaffold(
      backgroundColor: Color(0xFF2a2f32),
      appBar: AppBar(
        backgroundColor: Color(0xFF2a2f32),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 2.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(Icons.arrow_back),
                CircleAvatar(
                  radius: 12,
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          user["name"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
              color: Color(0xFF2a2f38),
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Archive',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Center(
                      child: Text(
                        'Clear Chat',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ];
              }),
        ],
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.face, color: Colors.grey),
                          // suffixIcon: IconButton(
                          //   Icons.send,
                          //   iconSize: 30.0,
                          //   color: Colors.white,
                          //   onPressed: () {

                          //   },
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(40.0),
                          //   borderSide: BorderSide(color: Colors.grey),
                          // ),
                          hintText: 'Type a message',
                          fillColor: Colors.grey,
                        ),
                        controller: messageController,
                        onChanged: (value) {
                          messageTyped = value;
                        },
                      ),
                    ),
                    SizedBox(width: 3.0),
                    FloatingActionButton(
                      child: Icon(Icons.send),
                      onPressed: () {
                        DatabaseMethods().sendmessage(messageTyped);
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
