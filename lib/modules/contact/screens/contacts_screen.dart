import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/modules/auth/stores/auth_store.dart';
import 'package:real_time_chat/modules/contact/stores/contact_store.dart';
import 'package:real_time_chat/modules/contact/widgets/contact_list.dart';
import 'package:real_time_chat/modules/contact/widgets/custom_drawer.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late final ContactStore contactStore;
  late final AuthStore authStore;
  @override
  void initState() {
    super.initState();
    contactStore = Provider.of<ContactStore>(context, listen: false);
    authStore = Provider.of<AuthStore>(context, listen: false);
    contactStore.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contactos",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: CustomDrawer(authStore: authStore),
      body: Observer(
        builder: (_) {
          if (contactStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (contactStore.contacts.isEmpty) {
            return const Center(
              child: Text(
                "No hay contactos disponibles",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await contactStore.loadContacts();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: ContactList(
                contactStore: contactStore,
              ),
            ),
          );
        },
      ),
    );
  }
}
