import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Contact? c2;
  @override
  Widget build(BuildContext context) {
    c2=ModalRoute.of(context)!.settings.arguments as Contact;
    return SafeArea(child: Scaffold(
        appBar: AppBar(title: Text(
          "View Contact",
          style: Theme.of(context).textTheme.titleLarge
        ),),
        body:
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: c2?.image=="assets/image/profile.png"
                            ?
                        const Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage("assets/image/profile.png"),
                          ),
                        ): Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(c2!.image!)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: Text(
                          "${c2?.name}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                      ),
                      const SizedBox(height: 15,),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async{
                            Uri mail= Uri.parse("mailto :${c2!.email}");
                            await launchUrl(mail);
                          },
                            child: CircleAvatar(child: Icon(Icons.mail,size: 25,color: Colors.white,),backgroundColor: Colors.blue,radius: 20,)),
                        Text("email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                    const Column(
                      children: [
                        CircleAvatar(child: Icon(Icons.message,size: 25,color: Colors.white,),backgroundColor: Colors.red,radius: 20,),
                        Text("Video Call",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(onTap: () async {
                          Uri call= Uri.parse("tel : +91${c2!.mobile}");
                          await launchUrl(call);
                        },
                            child: const CircleAvatar(child: Icon(Icons.call,size: 25,color: Colors.white,),backgroundColor: Colors.green,radius: 20,)),
                        const Text("Call",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                const Align(
                  alignment: AlignmentDirectional.topStart,
                    child: Text("NOW",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Row(children: [
                  Column(
                    children: [
                      Text("${c2?.mobile}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("${c2?.email}",style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.mail,size: 30,),
                  const SizedBox(width: 15,),
                  const Icon(Icons.call,size: 30,),

                ],)
              ],
            ),
          ),
        )
    ));
  }
}
