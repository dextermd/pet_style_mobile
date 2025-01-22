import 'package:pet_style_mobile/src/data/model/auth_response/auth_response.dart';

abstract interface class AuthRepository {
  Future<AuthResponse?> login(String email, String password);
  Future<AuthResponse?> register(String name, String email, String password);
  Future<AuthResponse?> refreshToken(String oldToken);
  Future<void> logOutUI();
  Future<void> logOutDB();

  Future<AuthResponse?> googleSignIn(String idToken);
}
