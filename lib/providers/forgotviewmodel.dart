import 'package:connection/repositories/forgot_repository.dart';
import 'package:flutter/cupertino.dart';

class ForgotViewModel with ChangeNotifier{
  final forgotRepo = ForgotRepository();
  String errormessage = "";
  int status = 0; //0-chua gui, 1 dang gui, 2 loi, 3-thanh cong
  Future<void> forgotPassword(String email) async{
    status =1;
    notifyListeners();
    errormessage = "";
    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if(emailValid == false){
      status = 2;
      errormessage += "Email không hợp lệ!\n";

    }
    if(status != 2){
     if(await forgotRepo.forgotPassword(email) == true ){
       status =3;
     }
     else{
       status = 2;
       errormessage = "Email không tồn tại!";
     }
    }
    notifyListeners();
  }
}