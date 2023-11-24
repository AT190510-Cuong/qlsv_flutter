import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page_login.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routeName = '/forgot';
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewmodel =  Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(


              child:

                  viewmodel.status == 3 ?
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      // Icon(
                      //   Icons.check,
                      //   color: Colors.green,
                      //   size: 50,
                      // ),
                        Image.network("https://media.giphy.com/media/xUOxf0akiVBK6R8jGU/giphy.gif"),
                      const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                              ),
                              Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text("Gửi yêu cầu tái tạo mật khẩu thành công. Truy cập vào email và làm theo hướng dẫn!",),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 40,
                          ),


                          GestureDetector(
                            onTap: (){
                              viewmodel.status = 0;
                              Navigator.popAndPushNamed(context, PageLogin.routename);
                            },
                            child: Text("Bấm vào đây ",
                              style: AppConstant.textlink,),
                          ),
                          const Text("để đăng nhập"),
                        ],
                      )

                    ],),
                  )
                     :
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Image.network(
                      'https://th.bing.com/th/id/R.6a025e3d44c42575f5c915a255dc6b73?rik=KzH%2baL6C8CKNgw&pid=ImgRaw&r=0',
                    ),

                      const Text("Hãy điền email để thực hiện quy trình tái tạo mật khẩu."),
                        const SizedBox(height: 10,),
                        CustomTextField(textController: _emailController, hintText: "Email", obscureText: false),
                        const SizedBox(height: 10,),
                        Text(viewmodel.errormessage, style: AppConstant.texterror,),
                        GestureDetector(
                          onTap: (){

                            final email = _emailController.text.trim();
                            viewmodel.forgotPassword(email);
                          },
                            child: const CustomButton(textButton: "Gửi yêu cầu")),
                        const SizedBox(height: 10,),
                        GestureDetector(
                            onTap: () => {
                              Navigator.of(context).popAndPushNamed(PageLogin.routename),
                            },
                            child: Text("Đăng nhập >>", style: AppConstant.textlink,)),
                      ],
                    ),
                  ),
                  viewmodel.status ==1 ? CustomSpinner(size: size) : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
