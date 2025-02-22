import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'contact_store.g.dart';

class ContactStore = ContactStoreBase with _$ContactStore;

abstract class ContactStoreBase with Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  ObservableList<Map<String, dynamic>> contacts =
      ObservableList<Map<String, dynamic>>();

  @observable
  bool isLoading = false;

  @action
  Future<void> loadContacts() async {
    isLoading = true;
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      final snapshot = await    _firestore.collection('users').get();
      contacts.clear();

      for (var doc in snapshot.docs) {
        if (doc.id != userId) {
          // Evita mostrar al usuario logeado en la lista
          contacts.add({
            'uid': doc.id,
            'email': doc['email'],
            'name': doc['name'],
          });
        }
      }
    } catch (e) {
      debugPrint("Error cargando contactos: $e");
    } finally {
      isLoading = false;
    }
  }
}
