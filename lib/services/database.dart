import 'package:chatapp/views/chat-room-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';

class DatabaseMethods {
  static DatabaseMethods _inst;
  DatabaseMethods._create();
  factory DatabaseMethods() {
    if (_inst == null) _inst = DatabaseMethods._create();

    return _inst;
  }
  Future<void> initApp() async {
    if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  }

  Future<Map<String, dynamic>> getUserByUsername(String username) async {
    await initApp();
    final snap = await FirebaseFirestore.instance
        .collection("users")
        .where('name', isGreaterThanOrEqualTo: username)
        .get();

    print(snap);
//vha vbhai 5 tarik kbaad error aa gya
    return snap.docs.first.data();
  }

  Stream<QuerySnapshot> getUsersList() async* {
    await initApp();
    yield* FirebaseFirestore.instance.collection('users').get().asStream();
  }

  createChatRoom() {
    FirebaseFirestore.instance.collection('ChatRoom').doc(ChatRoom.id);
  }

  Future<void> uploadUserInfo(String uid, Map<String, dynamic> userMap) async {
    await initApp();
    return FirebaseFirestore.instance.collection('users').doc(uid).set(userMap);
  }

  // getConversationMessages(String chatRoomId, messageMap) {
  //   FirebaseFirestore.instance
  //       .collection('chatroom')
  //       .doc(chatRoomId)
  //       .collection('chats')
  //       .add(messageMap);
  // }

  Future<void> sendmessage(String msg) async {
    try {
      // messageTextController.clear();
      //messageTyped + LoggedInUserEmail
      await FirebaseFirestore.instance.collection('messages').add({
        'text': msg,
        'sender': AuthMehtods().user.email,
      });
    } catch (e) {
      print(e);
    }
  }
}
