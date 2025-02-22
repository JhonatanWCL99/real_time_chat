import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:real_time_chat/modules/auth/widgets/auth_form_fields.dart';
import 'package:real_time_chat/modules/contact/screens/contacts_screen.dart';
import 'package:real_time_chat/modules/auth/stores/auth_store.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "CREAR CUENTA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthFormFields(
                      emailController: emailController,
                      passwordController: passwordController,
                      nameController: nameController,
                      formKey: formKey,
                      isRegister: true,
                    ),
                    const SizedBox(height: 24),
                    Observer(
                      builder: (_) {
                        if (authStore.signUpState == AuthState.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (authStore.signUpState == AuthState.error) {
                          return Text(
                            authStore.signUpError ?? "Error desconocido",
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          );
                        } else if (authStore.signUpState == AuthState.success) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            authStore.signUpState = AuthState.idle;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContactsScreen()),
                            );
                          });
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await authStore.signUp(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "¿Ya tienes cuenta? Inicia sesión",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
