import 'package:flutter/material.dart';

import '../../model/contact_model.dart';

class Provider1 with ChangeNotifier
{
  List<Contact> contactList=[
  ];
  bool theme=false;
  String? path;
  ThemeMode mode=ThemeMode.light;
  int step=0;
  void cancelStep()
  {
    if(step>0)
      {
        step--;
        notifyListeners();
      }
  }
  void continueStep()
  {
    if(step<3)
      {
        step++;
        notifyListeners();
      }
  }
  void setTheme()
  {
    theme=!theme;
    if(theme)
    {
      mode=ThemeMode.dark;
    }
    else{
      mode=ThemeMode.light;
    }
    notifyListeners();
  }
  void addData({required Contact c1})
  {
    contactList.add(c1);
    notifyListeners();
  }
}
