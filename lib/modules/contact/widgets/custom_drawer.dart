import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:real_time_chat/modules/auth/screens/login_screen.dart';
import 'package:real_time_chat/modules/auth/stores/auth_store.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.authStore,
  });

  final AuthStore authStore;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Observer(
        builder: (_) {
          if (authStore.logoutState == AuthState.success) {
            Future.microtask(() {
              authStore.logoutState = AuthState.idle;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
                (route) => false,
              );
            });
          }

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildUserHeader(authStore),
              _buildLogoutTile(authStore),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserHeader(AuthStore authStore) {
    return UserAccountsDrawerHeader(
      accountName: Text(authStore.user?.email ?? "Usuario Desconocido"),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          authStore.user?.email?[0].toUpperCase() ?? "U",
          style: const TextStyle(fontSize: 40.0, color: Colors.blueAccent),
        ),
      ),
      decoration: const BoxDecoration(color: Colors.blueAccent),
    );
  }

  Widget _buildLogoutTile(AuthStore authStore) {
    return ListTile(
      leading: const Icon(Icons.exit_to_app, color: Colors.black),
      title: const Text("Cerrar Sesión"),
      onTap: authStore.signOut,
    );
  }
}
