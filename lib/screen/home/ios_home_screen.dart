import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class HomeScreenIos extends StatefulWidget {
  const HomeScreenIos({super.key});

  @override
  State<HomeScreenIos> createState() => _HomeScreenIosState();
}

class _HomeScreenIosState extends State<HomeScreenIos> {
  Provider1? providerR;
  Provider1? providerW;
  @override
  Widget build(BuildContext context) {
    providerR=context.read<Provider1>();
    providerW=context.watch<Provider1>();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Contact App Ios"),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Center(
                child: CupertinoI(
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
                        Icon(CupertinoIcons.person_add,color: CupertinoColors.link,),
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
                              Cupertino(
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
        ),);
  }
}
