import 'package:contact_info/screen/intro/intro_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../screen/addData/add_data_screen.dart';
import '../../screen/details/details_screen.dart';
import '../../screen/home/home_screen.dart';
import '../../screen/splesh/splesh_screen.dart';

Map <String,WidgetBuilder> myRouts={
  "/":(context) => IntroScreen(),
  "splesh":(context) => const SpleshScreen_(),
  "home":(context) => const HomeScreen(),
  "add":(context) => const AddDataScreen(),
  "view":(context) => const DetailsScreen(),
};
Map <String,WidgetBuilder> myRouts1={
  "/":(context) => const SpleshScreen_(),
  "home":(context) => const HomeScreen(),
  "add":(context) => const AddDataScreen(),
  "view":(context) => const DetailsScreen(),
};