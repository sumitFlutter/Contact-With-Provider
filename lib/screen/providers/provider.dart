import 'package:contact_info/utils/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../model/contact_model.dart';

class Provider1 with ChangeNotifier
{
  LocalAuthentication auth = LocalAuthentication();
  List<Contact> contactList=[
  ];
  String? editI;
  bool theme=false;
  String? path= "assets/image/profile.png";
  ThemeMode mode=ThemeMode.light;
  bool pTheme=false;
  IconData themeMode=Icons.dark_mode;
  int step=0;
  bool introScreen=false;
  String introImage="assets/image/1.png";
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
    theme=!theme;
    saveTheme(pTheme: theme);
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
    notifyListeners();
  }
  void getTheme()
  async{
    if(await applyTheme()==null)
      {
        pTheme=false;
      }
    else
      {
        pTheme=(await applyTheme())!;
      }
    if(pTheme==true)
    {
      mode=ThemeMode.dark;
      themeMode=Icons.light_mode;
      introImage="assets/image/2.png";
    }
    else if(pTheme==false)
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
      introImage="assets/image/1.png";
    }
    else
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
      introImage="assets/image/1.png";
    }
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
  void getIntroStatus()
  async {
    introScreen=(await getIntro())??false;

    print("=============$introScreen");
  }
  void introToggle()
  {
    introScreen=true;
    setIntro(pIntro: introScreen);
  }
  void editP1(int index)
  {
    editI=contactList[index].image;
    notifyListeners();
  }
  void editP2(String image1)
  {
    editI=image1;
    notifyListeners();
  }
  void updateContact({required int index,required Contact c3})
  {
    contactList[index]=c3;
    notifyListeners();
  }
  Future<bool?> lock()
  async{
    bool check = await auth.canCheckBiometrics;
    if(check==true)
      {
        List<BiometricType> l1 = await auth.getAvailableBiometrics();
        if(l1.isNotEmpty)
          {
            final bool mainV = await auth.authenticate(
                localizedReason: 'Please authenticate to show account balance',
                options: const AuthenticationOptions(biometricOnly: true));
            return mainV;
          }
      }

    notifyListeners();
  }
}