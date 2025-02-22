import 'package:firebase_auth/firebase_auth.dart';

String handleFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'Este correo electrónico ya está en uso. Por favor, usa otro correo electrónico.';
    case 'weak-password':
      return 'La contraseña es demasiado débil. Por favor, elige una contraseña más fuerte.';
    case 'invalid-email':
      return 'La dirección de correo electrónico no es válida. Por favor, revisa el formato del correo electrónico.';
    case 'operation-not-allowed':
      return 'Esta operación no está permitida. Por favor, revisa la configuración de Firebase.';
    default:
      return e.message ?? 'Ocurrió un error desconocido.';
  }
}
