import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDslop extends StatelessWidget {
  const SubPageDslop({super.key});

  static int idpage = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child:
      Container(color: AppConstant.backgroundcolor, child: const Text("Ds lớp")),
    );
  }
}