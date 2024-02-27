import 'package:contact_info/screen/providers/provider.dart';
import 'package:contact_info/utils/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpleshScreen_ extends StatefulWidget {
  const SpleshScreen_({super.key});

  @override
  State<SpleshScreen_> createState() => _SpleshState();
}

class _SpleshState extends State<SpleshScreen_> {
  @override
  void initState() {
    super.initState();
    context.read<Provider1>().getIntroStatus();
    Future.delayed(Duration(seconds: 3),() => Navigator.pushReplacementNamed(context, context.read<Provider1>().introScreen?"home":"intro"),);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/logo/logo.png",height: 120,width: 120,fit: BoxFit.cover,)),
          const SizedBox(height: 5,),
          const Center(child: Text("Contact Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),)
        ],
      ),
    ),);
  }
}