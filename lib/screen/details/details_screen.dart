import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact_model.dart';
import '../providers/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Provider1? providerR;
  Provider1? providerW;
  int index=0;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtE = TextEditingController();
  @override
  Widget build(BuildContext context) {
    index=ModalRoute.of(context)!.settings.arguments as int;
    providerR=context.read<Provider1>();
    providerW=context.watch<Provider1>();
    return SafeArea(child: Scaffold(
        appBar: AppBar(title: Text(
          "View Contact",
          style: Theme.of(context).textTheme.titleLarge
        ),
        actions: [
          IconButton.outlined(onPressed: () {
            editContact();
          }, icon: const Icon(Icons.edit)),
          IconButton.outlined(onPressed: () {
            showDialog(context: context, builder: (context) => AlertDialog(title: const Text("Are you sure?"),actions: [
              ElevatedButton(onPressed: () {
                providerR!.remove(index);
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: const Text("Yes!")),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text("No!")),
            ],),);
          }, icon: const Icon(Icons.delete)),
        ],
        ),
        body:
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: providerR!.contactList[index].image=="assets/image/profile.png"
                        ?
                    const Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/image/profile.png"),
                      ),
                    ): Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File("${providerR!.contactList[index].image}")),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: Text(
                      "${providerR!.contactList[index].name}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
              const SizedBox(height: 15,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async{
                          Uri mail= Uri.parse("mailto:${providerR!.contactList[index].email}");
                          await launchUrl(mail);
                        },
                          child: const CircleAvatar(child: Icon(Icons.mail,size: 25,color: Colors.white,),backgroundColor: Colors.blue,radius: 20,)),
                      const Text("email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
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
                        Uri call= Uri.parse("tel:+91${providerR!.contactList[index].mobile}");
                        await launchUrl(call);
                      },
                          child: const CircleAvatar(child: Icon(Icons.call,size: 25,color: Colors.white,),backgroundColor: Colors.green,radius: 20,)),
                      const Text("Call",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("NOW",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  IconButton.filledTonal(onPressed: () {
                    Share.share("${providerR!.contactList[index].name}\n${providerR!.contactList[index].mobile}");
                  }, icon: Icon(Icons.share)),
                ],
              ),
              Row(children: [
                Column(
                  children: [
                    Text("+91 ${providerR!.contactList[index].mobile}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Text("${providerR!.contactList[index].email}",style: const TextStyle(fontSize: 15),),
                  ],
                ),
                Spacer(),
                IconButton.filledTonal(onPressed:() async{
                  Uri call= Uri.parse("tel:+91${providerR!.contactList[index].mobile}");
                  await launchUrl(call);
                },  icon: const Icon(Icons.call)),
                const SizedBox(width: 15,),
                IconButton.filledTonal(onPressed:() async{
                  Uri msg= Uri.parse("sms:+91${providerR!.contactList[index].mobile}");
                  await launchUrl(msg);
                },  icon: const Icon(Icons.message)),
              ],),
              Spacer(),
              BottomAppBar(child:  Center(
                child: IconButton(onPressed: () {
                  providerR!.createHidden(index);
                  Navigator.pop(context);
                },icon: Icon(Icons.lock),),
              ),)
            ],
          ),
        )
    ));
  }
  void editContact()
  {
    txtMobile.text=providerR!.contactList[index].mobile!;
    txtE.text=providerR!.contactList[index].email!;
    txtName.text=providerR!.contactList[index].name!;
    providerR!.editP1(index);
    showDialog(context: context, builder: (context) {
      return  Center(
        child: Material(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            color: Colors.primaries[index].shade300,
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          providerW!.editI==null
                              ?
                          const CircleAvatar(
                            radius: 90,
                            backgroundImage: AssetImage("assets/image/profile.png"),
                          ): CircleAvatar(
                            radius: 90,
                            backgroundImage: FileImage(File(providerW!.editI!)),
                          ),
                          Align(
                              alignment: const Alignment(0.8,0.8),
                              child: IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.camera);
                                    providerR!.editP2(image!.path);
                                },
                                icon: const Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.black,
                                  weight: 50,
                                ),
                              )),
                          Align(
                              alignment: const Alignment(-0.8,-0.8),
                              child: IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  providerR!.editP2(image!.path);
                                },
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.black,
                                  weight: 50,
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text(
                      "Name:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: txtName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Your name",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Mobile Number:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: txtMobile,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile number is required";
                        }
                        if(value!.length!=10)
                        {
                          return "Enter valid number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Mobile Number",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: const TextStyle(color: Colors.white),

                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Email Address",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: txtE,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        else if (!RegExp(
                            "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                            .hasMatch(value!)) {
                          return "enter the valid email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 15,),
                    Center(
                      child: ElevatedButton(onPressed: () {
                          if (key.currentState!.validate())
                          {
                            if(providerR!.editI==null)
                            {
                              ScaffoldMessenger.of(context)!.showSnackBar(const SnackBar(content: Text("Image is required")));
                            }
                            else{
                            Contact c4=Contact(name: txtName.text, mobile: txtMobile.text, image: providerR!.editI, email: txtE.text);
                            providerR!.updateContact(index: index, c3: c4);
                              txtName.clear();
                              txtMobile.clear();
                              txtE.clear();
                              ScaffoldMessenger.of(context)!.showSnackBar(const SnackBar(content: Text("Your Contact is updated")));
                              Future.delayed(const Duration(seconds: 1),() => Navigator.pop(context));
                            }

                          }
                      },child: Text("Submit",style: Theme.of(context).textTheme.labelLarge,),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }
}
