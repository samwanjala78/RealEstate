part of "../../homescout_library.dart";

Future<void> sendMessage(String chatId, String text, String senderId) async {
  final db = FirebaseFirestore.instance;

  final chatRef = db.collection("messages").doc(chatId);

  await chatRef.set({"chatId": chatId});

  final msgRef = chatRef.collection("chat_messages").doc();

  final msgId = db.databaseId;

  await msgRef.set({
    "messageId": msgId,
    "seen": false,
    "senderId": senderId,
    "text": text,
    "timestamp": FieldValue.serverTimestamp(),
  });

  await db.collection("chats").doc(chatId).set({
    "lastMessage": text,
    "lastTimestamp": FieldValue.serverTimestamp(),
    "chatId": chatId,
  }, SetOptions(merge: true));
}

Future<List<Message>> getMessages(String chatId) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("messages")
        .doc(chatId)
        .collection("chat_messages")
        .get();

    List<Message> messages = [];

    for (var doc in snapshot.docs) {
      final id = doc.id;
      final data = doc.data();
      Message message = Message.fromJson(messageId: id, json: data);
      messages.add(message);
    }

    return messages;
  } catch (e) {
    print("Firestore connection FAILED:");
    print(e);

    return [];
  }
}

Future<List<Chat>> getChats() async {
  QuerySnapshot<Map<String, dynamic>> snapshot;

  try {
    snapshot = await FirebaseFirestore.instance.collection("chats").get();
  } catch (e) {
    print("Firestore connection FAILEDDDD:");
    print(e);

    return [];
  }

  List<Chat> chats = [];

  for (var doc in snapshot.docs) {
    final id = doc.id;
    final data = doc.data();
    printRed(id);
    printRed(data);
    Chat chat = Chat.fromJson(chatId: id, json: data);

    printRed(chat.lastMessage);
    chats.add(chat);
  }

  return chats;
}
