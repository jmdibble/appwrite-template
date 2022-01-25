import 'package:appwrite/models.dart';
import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/enums/page_state.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/services/injector.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AuthHandlerViewModel extends BaseViewModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  AuthService get _authService => getIt.get<AuthService>();

  bool get isSignedIn => _authService.isSignedIn;
  AuthState authState = AuthState.notStarted;
  PageState pageState = PageState.login;

  Future<void> setSignedIn() async {
    authState = AuthState.initial;
    notifyListeners();
    final Session? session = await _authService.getActiveSession();
    if (session != null && session.current) {
      _authService.isSignedIn = true;
    }
    authState = AuthState.complete;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    authState = AuthState.loading;
    notifyListeners();
    final bool response = await _authService.createUser(name, email, password);
    if (response) {
      _authService.isSignedIn = true;
      emailController.text = "";
      pwController.text = "";
      nameController.text = "";
    }
    authState = AuthState.complete;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    authState = AuthState.loading;
    notifyListeners();
    final Session? response = await _authService.createSession(email, password);
    if (response != null && response.current) {
      _authService.isSignedIn = true;
      emailController.text = "";
      pwController.text = "";
    }
    authState = AuthState.complete;
    notifyListeners();
  }

  void goToLogin() {
    emailController.text = "";
    pwController.text = "";
    pageState = PageState.login;
    notifyListeners();
  }

  void goToSignup() {
    emailController.text = "";
    pwController.text = "";
    pageState = PageState.signup;
    notifyListeners();
  }
}
