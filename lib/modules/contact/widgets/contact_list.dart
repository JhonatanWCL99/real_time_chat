import 'package:flutter/material.dart';
import 'package:real_time_chat/modules/chat/screens/chat_screen.dart';
import 'package:real_time_chat/modules/contact/stores/contact_store.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
    required this.contactStore,
  });

  final ContactStore contactStore;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 15),
      separatorBuilder: (_, __) => const Divider(
        color: Colors.black26,
        height: 2,
      ),
      itemCount: contactStore.contacts.length,
      itemBuilder: (context, index) {
        return _buildContactTile(
          context,
          contactStore.contacts[index],
        );
      },
    );
  }

  Widget _buildContactTile(BuildContext context, Map<String, dynamic> contact) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(
          contact['name'] != null && contact['name'].isNotEmpty
              ? contact['name'][0].toUpperCase()
              : '',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        contact['name'],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact['email'],
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              contactId: contact['uid'],
              contactName: contact['name'],
              contactEmail: contact['email'],
            ),
          ),
        );
      },
    );
  }
}
