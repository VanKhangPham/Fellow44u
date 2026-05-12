import 'api_services.dart';

class AuthService {
  static Future<String?> signIn(String email, String password) async {
    try {
      final respone = await ApiService.post('/auth/sign-in', {
        'email': email,
        'password': password,
      });

      if (respone['success'] == true) {
        final token = respone['data']['accessToken'];
        await ApiService.saveToken(token);
        return token;
      } else {
        throw Exception(respone['message'] ?? 'Sign-in failed');
      }
    } catch (e) {
      throw Exception('Sign-in error: $e');
    }
  }

  static Future<String?> signUp(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final response = await ApiService.post('/auth/sign-up', {
        'fullname': fullName,
        'email': email,
        'password': password,
      });

      if (response['success'] == true) {
        final token = response['data']['accessToken'];
        await ApiService.saveToken(token);
        return token;
      } else {
        throw Exception(response['message'] ?? 'Sign-up failed');
      }
    } catch (e) {
      throw Exception('Sign-up error: $e');
    }
  }
}
