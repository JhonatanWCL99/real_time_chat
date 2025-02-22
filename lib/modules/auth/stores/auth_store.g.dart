// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$userAtom = Atom(name: 'AuthStoreBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$signInStateAtom =
      Atom(name: 'AuthStoreBase.signInState', context: context);

  @override
  AuthState get signInState {
    _$signInStateAtom.reportRead();
    return super.signInState;
  }

  @override
  set signInState(AuthState value) {
    _$signInStateAtom.reportWrite(value, super.signInState, () {
      super.signInState = value;
    });
  }

  late final _$signUpStateAtom =
      Atom(name: 'AuthStoreBase.signUpState', context: context);

  @override
  AuthState get signUpState {
    _$signUpStateAtom.reportRead();
    return super.signUpState;
  }

  @override
  set signUpState(AuthState value) {
    _$signUpStateAtom.reportWrite(value, super.signUpState, () {
      super.signUpState = value;
    });
  }

  late final _$logoutStateAtom =
      Atom(name: 'AuthStoreBase.logoutState', context: context);

  @override
  AuthState get logoutState {
    _$logoutStateAtom.reportRead();
    return super.logoutState;
  }

  @override
  set logoutState(AuthState value) {
    _$logoutStateAtom.reportWrite(value, super.logoutState, () {
      super.logoutState = value;
    });
  }

  late final _$signInErrorAtom =
      Atom(name: 'AuthStoreBase.signInError', context: context);

  @override
  String? get signInError {
    _$signInErrorAtom.reportRead();
    return super.signInError;
  }

  @override
  set signInError(String? value) {
    _$signInErrorAtom.reportWrite(value, super.signInError, () {
      super.signInError = value;
    });
  }

  late final _$signUpErrorAtom =
      Atom(name: 'AuthStoreBase.signUpError', context: context);

  @override
  String? get signUpError {
    _$signUpErrorAtom.reportRead();
    return super.signUpError;
  }

  @override
  set signUpError(String? value) {
    _$signUpErrorAtom.reportWrite(value, super.signUpError, () {
      super.signUpError = value;
    });
  }

  late final _$logoutErrorAtom =
      Atom(name: 'AuthStoreBase.logoutError', context: context);

  @override
  String? get logoutError {
    _$logoutErrorAtom.reportRead();
    return super.logoutError;
  }

  @override
  set logoutError(String? value) {
    _$logoutErrorAtom.reportWrite(value, super.logoutError, () {
      super.logoutError = value;
    });
  }

  late final _$signUpAsyncAction =
      AsyncAction('AuthStoreBase.signUp', context: context);

  @override
  Future<void> signUp(String name, String email, String password) {
    return _$signUpAsyncAction.run(() => super.signUp(name, email, password));
  }

  late final _$signInAsyncAction =
      AsyncAction('AuthStoreBase.signIn', context: context);

  @override
  Future<void> signIn(String email, String password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  late final _$signOutAsyncAction =
      AsyncAction('AuthStoreBase.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  @override
  String toString() {
    return '''
user: ${user},
signInState: ${signInState},
signUpState: ${signUpState},
logoutState: ${logoutState},
signInError: ${signInError},
signUpError: ${signUpError},
logoutError: ${logoutError}
    ''';
  }
}
