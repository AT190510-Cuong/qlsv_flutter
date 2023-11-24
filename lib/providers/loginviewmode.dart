import 'package:connection/models/student.dart';
import 'package:connection/repositories/login_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
// import 'package:connection/services/api_service.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0; //0-not login, 1-waiting, 2-error, 3- already logged
  // final api = ApiService();

  LoginRepository loginRepo = LoginRepository();

  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
      if (profile.token == "") {
        status = 2;
        errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng!";
      } else {
          status = 3;
        // đăng nhập thành công, lấy thông tin user student
        var student = await StudentRepository().getStudnetInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
        //status = 3;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
