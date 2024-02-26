import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/contact_model.dart';
import '../providers/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Provider1? providerR;
  Provider1? providerW;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? editI;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtE = TextEditingController();

  @override
  Widget build(BuildContext context) {
    providerR=context.read<Provider1>();
    providerW=context.watch<Provider1>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "My Contacts",
          style: Theme.of(context).textTheme.titleLarge
        ),
        actions: [
          IconButton(onPressed: () => providerR!.setTheme(), icon: Icon(providerW!.themeMode))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "add");
                },
                child: Container(
                  height: 45,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.lightBlue.shade50,),
                  child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add,color: Colors.lightBlue,),
                    SizedBox(width: 10,),
                    Text("Create a new contact",style: Theme.of(context).textTheme.labelLarge,)
                  ],
                ),),
              ),
            ),
                Expanded(
                child: ListView.builder(
                  itemCount: providerW?.contactList.length,
                  itemBuilder: (context, index) => Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "view",arguments: providerW?.contactList[index]);
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [providerW?.contactList[index].image=="assets/image/profile.png"?
                              CircleAvatar(
                                  radius: 25,
                              backgroundImage: AssetImage(providerW!.contactList[index].image!),):
                                      CircleAvatar(
                                      radius: 25,
                                          backgroundImage: FileImage(
                                              File(providerW!.contactList[index].image!))),
                              const SizedBox(width: 20,),
                              Text(
                                "${providerW?.contactList[index].name}",
                                style: const TextStyle(fontWeight: FontWeight.bold,),
                              ),
                              const Spacer(),
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        txtMobile.text=providerR!.contactList[index].mobile!;
                                        txtE.text=providerR!.contactList[index].email!;
                                        txtName.text=providerR!.contactList[index].name!;
                                        editI=providerR!.contactList[index].image!;
                                      });
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
                                                           editI==null
                                                               ?
                                                           const CircleAvatar(
                                                             radius: 90,
                                                             backgroundImage: AssetImage("assets/image/profile.png"),
                                                           ): CircleAvatar(
                                                             radius: 90,
                                                             backgroundImage: FileImage(File(editI!)),
                                                           ),
                                                           Align(
                                                               alignment: const Alignment(0.8,0.8),
                                                               child: IconButton(
                                                                 onPressed: () async {
                                                                   ImagePicker picker = ImagePicker();
                                                                   XFile? image = await picker.pickImage(
                                                                       source: ImageSource.camera);
                                                                   setState(() {
                                                                     editI = image!.path;
                                                                   });
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
                                                                   setState(() {
                                                                     editI = image!.path;
                                                                   });
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
                                                         setState(() {
                                                           if (key.currentState!.validate())
                                                           {
                                                             if(editI==null)
                                                             {
                                                               ScaffoldMessenger.of(context)!.showSnackBar(const SnackBar(content: Text("Image is required")));
                                                             }
                                                             else{
                                                              providerR!.contactList[index].name=txtName.text;
                                                              providerR!.contactList[index].email=txtE.text;
                                                              providerR!.contactList[index].mobile=txtMobile.text;
                                                              providerR!.contactList[index].image=editI;
                                                               txtName.clear();
                                                               txtMobile.clear();
                                                               txtE.clear();
                                                               ScaffoldMessenger.of(context)!.showSnackBar(const SnackBar(content: Text("Your Contact is saved")));
                                                               Future.delayed(const Duration(seconds: 1),() => Navigator.pop(context));
                                                             }

                                                           }
                                                         });
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
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                              const SizedBox(width: 7,),
                              Container(
                                child: IconButton(
                                    onPressed: () {

                                        providerR!.remove(index);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
