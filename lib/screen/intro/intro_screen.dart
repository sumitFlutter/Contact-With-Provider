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
    providerR=context.read<Provider1>();
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
          title: "Welcome To Contact App",
          bodyWidget: ElevatedButton(onPressed:() {
            providerR!.introToggle();
            Navigator.pushReplacementNamed(context, "splesh");
          },
          child: Text("next"),),

        )
      ],
      showDoneButton: false,
      showNextButton: false,
      showBackButton: false,
      showSkipButton: false,
    );
  }
}
