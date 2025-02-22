import 'dart:async';
import 'dart:developer';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
import 'package:async/async.dart';

part 'chat_store.g.dart';

class ChatStore = ChatStoreBase with _$ChatStore;

abstract class ChatStoreBase with Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @observable
  ObservableList<Message> messages = ObservableList<Message>();

  @observable
  bool isLoading = true;

  StreamSubscription? _messagesSubscription;

  @action
  void listenToMessages(String senderId, String receiverId) {
    messages.clear();
    isLoading = true;

    // Cancelar suscripción previa si existe
    _messagesSubscription?.cancel();

    final sentMessagesStream = _firestore
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .snapshots();

    final receivedMessagesStream = _firestore
        .collection('messages')
        .where('senderId', isEqualTo: receiverId)
        .where('receiverId', isEqualTo: senderId)
        .snapshots();

    final mergedStream =
        StreamGroup.merge([sentMessagesStream, receivedMessagesStream]);

    _messagesSubscription = mergedStream.listen((QuerySnapshot snapshot) {
      List<Message> allMessages = List.from(messages);

      for (var change in snapshot.docChanges) {
        final data = change.doc.data();
        if (data is Map<String, dynamic>) {
          final message = Message.fromMap(data);

          switch (change.type) {
            case DocumentChangeType.added:
              allMessages.add(message);
              break;
            case DocumentChangeType.modified:
              final index = allMessages
                  .indexWhere((m) => m.timestamp == message.timestamp);
              if (index != -1) allMessages[index] = message;
              break;
            case DocumentChangeType.removed:
              allMessages.removeWhere((m) => m.timestamp == message.timestamp);
              break;
          }
        }
      }

      allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      runInAction(() {
        messages.clear();
        messages.addAll(allMessages);
        isLoading = false;
      });

      log('Updated messages count: ${messages.length}');
    });
  }

  @action
  Future<void> sendMessage(
    String text,
    String senderId,
    String receiverId,
  ) async {
    final newMessage = Message(
      text: text,
      senderId: senderId,
      receiverId: receiverId,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('messages').add(newMessage.toMap());
  }

  @action
  void dispose() {
    _messagesSubscription?.cancel();
  }
}
