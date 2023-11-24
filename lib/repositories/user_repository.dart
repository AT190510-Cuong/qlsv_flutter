import 'package:connection/services/api_service.dart';

import '../models/user.dart';

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getStudentInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromJson(json);
    }

    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }
}
