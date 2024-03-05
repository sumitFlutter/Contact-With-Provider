import 'package:contact_info/screen/providers/provider.dart';
import 'package:contact_info/utils/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Provider1? providerR;
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    providerR = context.read<Provider1>();
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
          useScrollView: false,
          title: "Demo of ContactViewScreen",
          bodyWidget: Column(
            children: [
              Image.asset(providerR!.introImage,height: MediaQuery.sizeOf(context).height*0.7,width: MediaQuery.sizeOf(context).width,fit: BoxFit.fill,),
            ],
          ),

        ),
      ],
      showSkipButton: true,
      showNextButton: false,
      skip: const Text("Skip",style: TextStyle(color: Colors.grey),),
      onSkip: () {
        Navigator.pushReplacementNamed(context, "home");
      },
      done: const Text("Done"),
      onDone: () {
        providerR!.introToggle();
        Navigator.pushReplacementNamed(context, "home");
      },
    );
  }
}
