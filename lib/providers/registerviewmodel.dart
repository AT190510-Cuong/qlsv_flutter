import 'package:connection/repositories/register_repository.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModel with  ChangeNotifier{
  int status = 0; //0-chua dăng kí, 1-đang đăng ký,2- đăng kí lỗi, 3- đăng kí cần xác minh email, 4- dk không xác minh email
  String errormessage = "";
  bool agree  = false;
  final registerRepo = RegisterRepository();
  String  quydinh = "Khi tham gia vào ứng dụng các ban phải đồng ý với các điều khoản như sau:\n"
  + "1. Các thông tin của bạn sẽ được chia sẻ với các thành viên\n"
  + "2. Thông tin của bạn có thể ảnh hưởng đến kết quả học tập ở trường\n"
  + "3. Thông tin của bạn sẽ b xóa vĩnh khi có yêu cầu xoá thông tin\n";
  void setAgree(bool value){
    agree = value;
    notifyListeners();
  }

  Future<void> register(String email, String username, String pass1, String pass2) async{

    status = 1;
    notifyListeners();
    errormessage = "";
    if(agree == false){
      status = 2;
      errormessage += "Bạn phải đồng ý điều khoản trước khi đăng ký!\n";
    }
    if(email.isEmpty || username.isEmpty || pass1.isEmpty){
      status =2;
      errormessage += "Email, username, password không được để trống\n";
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if(emailValid == false){
      status = 2;
      errormessage += "Email không hợp lệ!\n";

    }
    if(pass1.length < 8 ){
      status = 2;
      errormessage += "Password cần lớn hợn 8!\n";
    }
    if(pass1 != pass2){
      status = 2;
      errormessage += "Mật khẩu không giống nhau!";
    }
    if(status != 2 ){
      status = await registerRepo.register(email, username, pass1);
    }

    // dùng repository gọi hàm login và trả lại kết quả

    notifyListeners();
  }
}