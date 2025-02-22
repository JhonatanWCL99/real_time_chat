import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:real_time_chat/modules/auth/stores/auth_store.dart';
import 'package:real_time_chat/modules/chat/stores/chat_store.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.chatStore,
    required this.authStore,
  });

  final ChatStore chatStore;
  final AuthStore authStore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(
        builder: (_) {
          log('chatStore Observer: ${chatStore.messages.length}');

          if (chatStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            reverse: true,
            itemCount: chatStore.messages.length,
            itemBuilder: (context, index) {
              final message = chatStore.messages[index];
              final isMe = message.senderId == authStore.user?.uid;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blueAccent : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: isMe
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black87,
                        fontSize: 16),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
