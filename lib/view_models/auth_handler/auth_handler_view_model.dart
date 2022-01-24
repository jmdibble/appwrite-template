import 'package:appwrite/models.dart';
import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/services/injector.dart';
import 'package:stacked/stacked.dart';

class AuthHandlerViewModel extends BaseViewModel {
  AuthService get _authService => getIt.get<AuthService>();

  bool get isSignedIn => _authService.isSignedIn;
  AuthState authState = AuthState.notStarted;

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

  Future<void> register(String email, String password) async {
    authState = AuthState.loading;
    notifyListeners();
    final bool response = await _authService.createUser(email, password);
    if (response) {
      _authService.isSignedIn = true;
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
    }
    authState = AuthState.complete;
    notifyListeners();
  }
}
