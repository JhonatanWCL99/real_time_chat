
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat/utils/handle_firebase_auth_error.dart';

part 'auth_store.g.dart';

enum AuthState { idle, loading, success, error }

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @observable
  User? user;

  @observable
  AuthState signInState = AuthState.idle;

  @observable
  AuthState signUpState = AuthState.idle;

  @observable
  AuthState logoutState = AuthState.idle;

  @observable
  String? signInError;

  @observable
  String? signUpError;

  @observable
  String? logoutError;

  AuthStoreBase() {
    _auth.authStateChanges().listen((User? newUser) {
      user = newUser;
    });
  }

  @action
  Future<void> signUp(String name, String email, String password) async {
    try {
      signUpState = AuthState.loading;
      signUpError = null;
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = credential.user!;

      await _firestore.collection('users').doc(user!.uid).set({
        'uid': user!.uid,
        'name': name,
        'email': user!.email,
      });

      signUpState = AuthState.success;
    } catch (e) {
      if (e is FirebaseAuthException) {
        signUpError = handleFirebaseAuthError(e);
      } else {
        signUpError = e.toString();
      }
      signUpState = AuthState.error;
    }
  }

  @action
  Future<void> signIn(String email, String password) async {
    try {
      signInState = AuthState.loading;
      signInError = null;
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = credential.user;
      signInState = AuthState.success;
    } catch (e) {
      if (e is FirebaseAuthException) {
        signInError = handleFirebaseAuthError(e);
      } else {
        signInError = e.toString();
      }
      signInState = AuthState.error;
    }
  }

  @action
  Future<void> signOut() async {
    try {
      logoutState = AuthState.loading;
      logoutError = null;
      await _auth.signOut();
      user = null;
      logoutState = AuthState.success;
    } catch (e) {
      logoutError = e.toString();
      logoutState = AuthState.error;
    }
  }
}
