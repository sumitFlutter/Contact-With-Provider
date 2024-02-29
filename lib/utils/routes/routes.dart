import 'package:contact_info/screen/hidden/hidden_screen.dart';
import 'package:contact_info/screen/intro/intro_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../screen/addData/add_data_screen.dart';
import '../../screen/details/details_screen.dart';
import '../../screen/home/home_screen.dart';
import '../../screen/splesh/splesh_screen.dart';

Map <String,WidgetBuilder> myRouts={
  "/":(context) => const SpleshScreen_(),
  "intro":(context) => IntroScreen(),
  "home":(context) => const HomeScreen(),
  "add":(context) => const AddDataScreen(),
  "view":(context) => const DetailsScreen(),
  "hide":(context) => HiddenScreen(),
};