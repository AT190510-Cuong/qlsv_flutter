import 'package:connection/models/lop.dart';
import 'package:connection/models/profile.dart';
import 'package:connection/repositories/lop_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

class PageDangKyLop extends StatefulWidget {
  PageDangKyLop({super.key});

  @override
  State<PageDangKyLop> createState() => _PageDangKyLopState();
}

class _PageDangKyLopState extends State<PageDangKyLop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';

  @override
  void initState() {
    // TODO: implement initState
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Thêm thông tin cơ bản",
                style: AppConstant.textfancyheader2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Bạn không thể quay trở lại trang sau khi rời đi. Vì vậy hãy kiểm tra kĩ nhé!',
                style: AppConstant.texterror,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputTextFormField(
                title: "Tên:",
                value: ten,
                width: size.width,
                callback: (output) {
                  ten = output;
                },
              ),
              CustomInputTextFormField(
                title: "Mssv",
                value: mssv,
                width: size.width,
                callback: (output) {
                  mssv = output;
                },
              ),
              listlop!.isEmpty
                  ? FutureBuilder(
                      future: LopRepository().getDslop(),
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listlop = snapshot.data;
                          return CustomInputDropDown(
                            width: size.width,
                            list: listlop!,
                            title: "Lớp",
                            valueId: idlop,
                            valueName: tenlop,
                            callback: (outputId, outputName) {
                              idlop = outputId;
                              tenlop = outputName;
                            },
                          );
                        } else {
                          return Text('Lỗi xảy ra');
                        }
                      },
                    )
                  : CustomInputDropDown(
                      width: size.width,
                      list: listlop!,
                      title: "Lớp",
                      valueId: idlop,
                      valueName: tenlop,
                      callback: (outputId, outputName) {
                        idlop = outputId;
                        tenlop = outputName;
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    profile.student.mssv = mssv;
                    profile.student.idlop = idlop;
                    profile.student.tenlop = tenlop;
                    profile.user.first_name = ten;
                    await UserRepository().updateProfile();
                    await StudentRepository().dangkyLop();
                  },
                  child: const CustomButton(textButton: 'Lưu thông tin')),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.popAndPushNamed(context, PageMain.routename);
                },
                child: Text(
                  'Rời khỏi trang >> ',
                  style: AppConstant.textlink,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

