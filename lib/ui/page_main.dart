import 'package:connection/models/profile.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page_dklop.dart';
import 'subpagediemdanh.dart';
import 'subpagedshocphan.dart';
import 'subpagedslop.dart';
import 'subpageprofile.dart';
import 'subpagetimkiem.dart';
import 'subpagetintuc.dart';

class PageMain extends StatelessWidget {
  static String routename = '/';

  PageMain({super.key});

  final List<String> menuTitles = [
    "Tin tức",
    "Profile",
    "Điểm danh",
    "Tìm kiếm",
    "Ds lớp",
    "Ds học phần"
  ];

  final menuBar = MenuItemlist();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if(profile.token == ""){
      return PageRegister();
    }

    if(profile.student.mssv == ""){
      return PageDangKyLop();
    }

    Widget body = const SubPageTintuc();
    if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = const SubPageProfile();
    } else if (viewmodel.activemenu == SubPageProfile.idpage) {
      body = const SubPageProfile();
    } else if (viewmodel.activemenu == SubPageTimkiem.idpage) {
      body = const SubPageTimkiem();
    } else if (viewmodel.activemenu == SubPageDiemdanh.idpage) {
      body = const SubPageDiemdanh();
    } else if (viewmodel.activemenu == SubPageDslop.idpage) {
      body = const SubPageDslop();
    } else if (viewmodel.activemenu == SubPageDsHocphan.idpage) {
      body = const SubPageDsHocphan();
    }

    menuBar.initialize(menuTitles);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: GestureDetector(
          onTap: () => viewmodel.toggleMenu(),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return GestureDetector(
                onTap: () => viewmodel.closeMenu(),
                child: Container(
                  color: Colors.amber[100],
                  child:  Center(
                    child: body ,
                  ),
                ),
              );
            },
          ),
          viewmodel.menustatus == 1
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menuBarModel, child) {
                    return GestureDetector(
                      onPanUpdate: (details) {
                        menuBarModel.setOffset(details.localPosition);
                      },
                      onPanEnd: (details) {
                        menuBarModel.setOffset(const Offset(0, 0));
                        viewmodel.closeMenu();
                      },
                      child: Stack(
                        children: [
                          CustomMenuSideBar(size: size),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: menuBar,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(),
        ],
      )),
    );
  }
}

// "Tin tức",
// "Profile",
// "Điểm danh",
// "Tìm kiếm",
// "Ds lớp",
// "Ds học phần"




class MenuItemlist extends StatelessWidget {
  MenuItemlist({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];

  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems
          .add(MenuBarItem(
        idpage: i,
          containerkey: GlobalKey(), title: menuTitles[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.20,
        width: size.width* 0.65,
        child: Image.network("https://i.pinimg.com/originals/b9/27/58/b9275833962c801339d3b69266827b42.gif"),),
        Container(height: 2, width: size.width * 0.65,
        color: AppConstant.appbarcolor,),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.65,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuBarItems.length,
            itemBuilder: (context, index) {
              return menuBarItems[index];
            },
          ),
        ),
      ],
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerkey, required this.idpage,
  });

  final int idpage ;
  final String title;
  final GlobalKey containerkey;
  TextStyle style = AppConstant.textbody;

  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textbody;
    }
    if (containerkey.currentContext != null) {
      RenderBox box =
          containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if ((offset.dy < (position.dy - 60)) && (offset.dy > (position.dy - 120))) {
        style = AppConstant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textbody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menuBarModel.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 60,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

class CustomMenuSideBar extends StatelessWidget {
  const CustomMenuSideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      // width: size.width * 0.65,
      // height: size.height,
      // color: Colors.white,
      size: Size(size.width * 0.65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});

  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    }
    if (offset.dx < width) {
      kq = width + 80;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
