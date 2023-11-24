import 'package:connection/models/profile.dart';
import 'package:connection/providers/diachimodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';
import 'custom_control.dart';

class SubPageProfile extends StatelessWidget {
  const SubPageProfile({super.key});

  static int idpage = 1;

  Future<void> init(DiachiModel dcmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();

    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewmodel.displaySpinner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      viewmodel.hideSpinner();
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));

    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                // bắt đâầu header
                createHeader(size, profile),
                //end header
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomInputTextFormField(
                            width: size.width * 0.45,
                            title: 'Điện thoại',
                            value: profile.user.phone,
                            callback: (output) {
                              profile.user.phone = output;
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.phone,
                          ),
                          CustomInputTextFormField(
                            width: size.width * 0.45,
                            title: 'Ngày sinh',
                            value: profile.user.birthday,
                            callback: (output) {
                              if (AppConstant.isDate(output)) {
                                profile.user.birthday = output;
                              }
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.datetime,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: "Thành phố/Tỉnh",
                              valueId: profile.user.provinceid,
                              valueName: profile.user.provincename,
                              callback: (outputId, outputName) async {
                                viewmodel.displaySpinner();
                                profile.user.provinceid = outputId;
                                profile.user.provincename = outputName;
                                await dcmodel.setCity(outputId);
                                viewmodel.hideSpinner();
                              },
                              list: dcmodel.listCity),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ),
      ),
    );
  }

  Container createHeader(Size size, Profile profile) {
    return Container(
      // color: Colors.amber[100],
      height: size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppConstant.appbarcolor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textbodywhite,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomAvatar1(size: size),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profile.user.first_name,
                style: AppConstant.textbodyfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    'Mssv: ',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.mssv,
                    style: AppConstant.textbodywhitebold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Lớp: ',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.tenlop,
                    style: AppConstant.textbodywhitebold,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          '(chưa duyệt)',
                          style: AppConstant.textbodywhite,
                        )
                      : Text(""),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Vai trò:  ',
                    style: AppConstant.textbodywhite,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          'sinh viên',
                          style: AppConstant.textbodywhitebold,
                        )
                      : Text(
                          'giảng viên',
                          style: AppConstant.textbodywhitebold,
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
