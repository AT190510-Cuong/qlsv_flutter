import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier{
  static final MainViewModel _instance = MainViewModel._internal();
  MainViewModel._internal();
  factory  MainViewModel(){
    return _instance;
  }

  int menustatus =0 ;// 0 là close, 1 là open
  int activemenu =0;// index của menu item
  void toggleMenu(){
    if(menustatus == 0){
      menustatus = 1;

    }else{
      menustatus =0;
    }
    notifyListeners();
  }

  void closeMenu(){
    menustatus = 0;
    notifyListeners();
  }

  void setActiveMenu(int index){

    activemenu =index;
    menustatus =0;
    notifyListeners();
  }


}