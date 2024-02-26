
import 'package:contact_info/screen/providers/provider.dart';
import 'package:contact_info/theme/theme.dart';
import 'package:contact_info/utils/routes/routes.dart';
import 'package:contact_info/utils/shared_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()
{

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Provider1())
      ],
      child: Consumer<Provider1>(
        builder:  (context, value,child) {
          return
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: value.mode,
            routes: myRouts,
          );
        },
      ),
    ),
  );
}