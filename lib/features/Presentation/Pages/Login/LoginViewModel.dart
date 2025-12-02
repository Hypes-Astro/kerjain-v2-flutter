import 'package:flutter_riverpod/legacy.dart';
import 'package:kerjain/features/Domain/Service/authService.dart';

class AuthViewModel extends StateNotifier<bool> {
  final AuthService _authService;

  AuthViewModel(this._authService) : super(false) {
    _init();
  }

  Future<void> _init() async {
    final isLoggedIn = await _authService.checkLoginStatus();
    state = isLoggedIn;
  }

  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    state = success;
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    state = false;
  } 
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, bool>((ref) {
  final authService = AuthService();
  return AuthViewModel(authService);
});
