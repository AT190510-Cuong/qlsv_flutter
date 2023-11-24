import '../services/api_service.dart';

class ForgotRepository{
  final ApiService api = ApiService();
  Future<bool> forgotPassword(String email) async {

    final response = await api.forgotPassword(email);
    if (response != null) {
        return true;
    }
    else {
      return false;
    }

  }
}