import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/provider/model/hrdmodel.dart';
import 'package:tugas_akhir/provider/service/hrd_service.dart';

import '../../../../provider/model/color_pallete.dart';

class DrawerHrd extends StatefulWidget {
  const DrawerHrd({super.key});

  @override
  State<DrawerHrd> createState() => _DrawerHrdState();
}

FirebaseAuth user = FirebaseAuth.instance;
var userdata = user.currentUser;

class _DrawerHrdState extends State<DrawerHrd> {
  List<bool> isHighlighted = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 2.2,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: DrawerHeader(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  Text(
                    '${userdata!.displayName}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${userdata!.email}',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Consumer<ServiceHrd>(
              builder: (context, menu, child) {
                return ListView.builder(
                    itemCount: menuDrawer.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          menu.setIndex = index;
                          menu.setSelect = index;
                        },
                        child: Container(
                          color: menu.getSelect[index]
                              ? Colors.grey.shade300
                              : Colors.white,
                          child: ListTile(
                            //the item
                            leading: Icon(
                              menuDrawer[index].icons,
                              color: Color.fromRGBO(29, 53, 87, 1),
                            ),
                            title: Text(menuDrawer[index].title),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.output,
                    color: Color.fromRGBO(29, 53, 87, 1),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => CupertinoAlertDialog(
                                    title: Text("Are you sure?"),
                                    content:
                                        Text("Anda yakin ingin keluar? O_o"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red.shade700),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green.shade700),
                                        ),
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          context.goNamed('login');
                                        },
                                      ),
                                    ])
                            // AlertDialog(
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10)),
                            //   title: Text("Are you sure?"),
                            //   content: Text("Anda yakin ingin keluar? O_o"),
                            //   actions: <Widget>[
                            //     ElevatedButton(
                            //       style: ElevatedButton.styleFrom(
                            //           backgroundColor: color[0].red),
                            //       onPressed: () {
                            //         Navigator.of(ctx).pop();
                            //       },
                            //       child: Text("Cancel"),
                            //     ),
                            //     ElevatedButton(
                            //       style: ElevatedButton.styleFrom(
                            //           backgroundColor: Colors.green),
                            //       onPressed: () {
                            //         _logout();
                            //         context.goNamed('login');
                            //       },
                            //       child: Text("OK"),
                            //     ),
                            //   ],
                            // ),
                            );
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ))
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
