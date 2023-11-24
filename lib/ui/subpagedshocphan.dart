import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDsHocphan extends StatelessWidget {
  const SubPageDsHocphan({super.key});

  static int idpage = 5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.backgroundcolor, child: const Text("Ds học phần")),
    );
  }
}