


import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/page_forgot.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/loginviewmode.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // // hàm login cũ
  // Future login(BuildContext context) async {
  //   String username = _emailController.text.trim();
  //   String password = _passwordController.text.trim();
  //   ApiService api = ApiService();
  //   Response? response = await api.loginUser(username, password);
  //   if(response?.statusCode == 200){
  //     Navigator.pop(context);
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const PageMain()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if(viewmodel.status == 3 ){
      Future.delayed(Duration.zero,
            (){
       Navigator.popAndPushNamed(context, PageMain.routename);
       //    Navigator.pop(context);
       //    Navigator.push(context, MaterialPageRoute(builder: (context) =>  PageMain()));
        },
      );
    }
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppLogo(),
                      const SizedBox(height: 30,),
                      const Text("Xin chào", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                      const Text("Nguyễn Hùng Cường", style: TextStyle(fontSize: 25)),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(hintText: "username",textController: _emailController, obscureText: false,),
                      const SizedBox(height: 20),

                      CustomTextField(hintText: "password",textController: _passwordController, obscureText: false,),
                      const SizedBox(height: 10,),

                      viewmodel.status == 2? Text(viewmodel.errorMessage, style: const TextStyle(color: Colors.red),) : const Text(""),
                      const SizedBox(height: 10),


                      GestureDetector(
                        onTap: (){
                          // login(context);
                          String username = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: const CustomButton(textButton: "Đăng nhập"),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const Text("Chưa có tài khoản? "),
                          GestureDetector(
                            onTap: () => {
                              Navigator.of(context).popAndPushNamed(PageRegister.routename),
                            },
                              child: Text("Đăng ký", style: TextStyle(fontWeight: FontWeight.bold  ,color: Colors.deepPurple[300]),)),
                        ],),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () => Navigator.of(context).popAndPushNamed(PageForgot.routeName),
                          child: Text("Quên mật khẩu?", style: AppConstant.textlink,)),
                    ],
                  ),

                ),

                viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



