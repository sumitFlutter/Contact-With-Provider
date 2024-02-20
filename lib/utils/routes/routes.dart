import 'package:flutter/cupertino.dart';

import '../../screen/addData/add_data_screen.dart';
import '../../screen/details/details_screen.dart';
import '../../screen/home/home_screen.dart';
import '../../screen/splesh/splesh_screen.dart';

Map <String,WidgetBuilder> myRouts={
  "/":(context) => const SpleshScreen_(),
  "home":(context) => const HomeScreen(),
  "add":(context) => const AddDataScreen(),
  "view":(context) => const DetailsScreen(),
};