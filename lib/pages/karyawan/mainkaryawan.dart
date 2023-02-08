import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/pages/karyawan/subpage/homepage.dart';

import '../../provider/model/color_pallete.dart';

class MainKaryawan extends StatefulWidget {
  MainKaryawan({super.key});

  @override
  State<MainKaryawan> createState() => _MainKaryawanState();
}

class _MainKaryawanState extends State<MainKaryawan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Anda yakin ingin keluar? O_o"),
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
                    ],
                  ),
                );
              },
              child: Image.asset(
                'assets/images/log-out.png',
                scale: 25,
                color: color[0].darkblue,
              ),
            )
          ],
          centerTitle: true,
          iconTheme: IconThemeData(color: color[0].darkblue),
          elevation: 0,
          backgroundColor: color[0].white,
          title: Text(
            "deKaryawan",
            style: TextStyle(color: color[0].darkblue),
          ),
        ),
        body: HomeKaryawan());
  }
}
