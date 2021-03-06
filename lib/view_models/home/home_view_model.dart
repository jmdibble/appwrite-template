import 'package:appwritetest/models/aw_user.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/services/injector.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  AuthService get _authService => getIt.get<AuthService>();

  AWUser? get user => _authService.user;

  Future<void> logout() async {
    final response = await _authService.deleteSession();
  }
}
