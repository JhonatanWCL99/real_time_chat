import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/modules/auth/stores/auth_store.dart';
import 'package:real_time_chat/modules/auth/screens/login_screen.dart';
import 'package:real_time_chat/modules/chat/stores/chat_store.dart';
import 'package:real_time_chat/modules/contact/screens/contacts_screen.dart';
import 'package:real_time_chat/modules/contact/stores/contact_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthStore>(create: (_) => AuthStore()),
        Provider<ChatStore>(create: (_) => ChatStore()),
        Provider<ContactStore>(create: (_) => ContactStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Real Time Chat with Firebase',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    if (authStore.user != null) {
      return const ContactsScreen();
    } else {
      return LoginScreen();
    }
  }
}
