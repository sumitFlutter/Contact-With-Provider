import 'package:contact_info/utils/shared_helper.dart';
import 'package:flutter/material.dart';

import '../../model/contact_model.dart';

class Provider1 with ChangeNotifier
{
  List<Contact> contactList=[
  ];
  bool? theme=false;
  String? path= "assets/image/profile.png";
  ThemeMode mode=ThemeMode.light;
  bool? pTheme;
  IconData themeMode=Icons.dark_mode;
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
  async {
    theme=!theme!;
    saveTheme(pTheme: theme!);
    pTheme=(await applyTheme())!;
    if(pTheme==true)
      {
        mode=ThemeMode.dark;
        themeMode=Icons.light_mode;
      }
    else if(pTheme==false)
      {
        mode=ThemeMode.light;
        themeMode=Icons.dark_mode;
      }
    else
      {
        mode=ThemeMode.light;
        themeMode=Icons.dark_mode;
      }
    print(pTheme);
    notifyListeners();
  }
  void getTheme()
  async{
    saveTheme(pTheme: theme!);
    pTheme=(await applyTheme())!;
    if(pTheme==true)
    {
      mode=ThemeMode.dark;
      themeMode=Icons.light_mode;
    }
    else if(pTheme==false)
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
    }
    else
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
    }
    print(pTheme);
    notifyListeners();
  }
  void addData({required Contact c1})
  {
    contactList.add(c1);
    notifyListeners();
  }
  void addPath(String p1)
  {
    path=p1;
    notifyListeners();
  }
  void remove(int index)
  {
    contactList.removeAt(index);
    notifyListeners();
  }
}
