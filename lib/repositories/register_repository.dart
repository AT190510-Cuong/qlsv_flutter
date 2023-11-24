import '../services/api_service.dart';

class RegisterRepository {
  final ApiService api = ApiService();

  Future<int> register(String email, String username, String password) async {
    int kq = 2;
    final response = await api.registerUse(email, username, password);
    if (response != null && response.statusCode == 201) {
      if (response.data['requires_email_confirmation'] == true) {
        kq = 3;
      } else {
        kq = 4;
      }
    }
    return kq;
  }
}
