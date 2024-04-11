import 'package:dash_chat_2/dash_chat_2.dart';

ChatUser user = ChatUser(
  id: '1',
  firstName: 'C3po',
  lastName: 'assistente fitual',
);

class ChatController {
  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey!',
      user: user,
      createdAt: DateTime.now(),
    ),
  ];
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}
