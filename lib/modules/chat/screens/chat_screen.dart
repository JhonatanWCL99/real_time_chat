import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/modules/auth/stores/auth_store.dart';
import 'package:real_time_chat/modules/chat/stores/chat_store.dart';
import 'package:real_time_chat/modules/chat/widgets/message_input.dart';
import 'package:real_time_chat/modules/chat/widgets/message_list.dart';

class ChatScreen extends StatefulWidget {
  final String contactId;
  final String contactName;
  final String contactEmail;

  const ChatScreen({
    super.key,
    required this.contactId,
    required this.contactName,
    required this.contactEmail,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatStore chatStore;
  late final AuthStore authStore;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    chatStore = Provider.of<ChatStore>(context, listen: false);
    authStore = Provider.of<AuthStore>(context, listen: false);
    _messageController = TextEditingController();
    chatStore.listenToMessages(
      authStore.user!.uid,
      widget.contactId,
    );
  }

  void sendMessage() {
    if (_messageController.text.isEmpty || authStore.user == null) {
      return;
    }

    chatStore.sendMessage(
      _messageController.text,
      authStore.user!.uid,
      widget.contactId,
    );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contactName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          MessageList(
            chatStore: chatStore,
            authStore: authStore,
          ),
          MessageInput(
            messageController: _messageController,
            sendMessage: sendMessage,
          ),
        ],
      ),
    );
  }
}
