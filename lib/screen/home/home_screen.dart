import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
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
          IconButton.filledTonal(onPressed: () {

                Navigator.pushNamed(context, "hide");

          }, icon: Icon(Icons.lock)),
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
                        Navigator.pushNamed(context, "view",arguments: index);
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
