import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/pages/hrd/subpage/component/drawer.dart';
import 'package:tugas_akhir/pages/hrd/subpage/component/hrdcontent.dart';
import 'package:tugas_akhir/provider/model/color_pallete.dart';
import 'package:tugas_akhir/provider/service/hrd_service.dart';

class MainHrd extends StatelessWidget {
  const MainHrd({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServiceHrd()),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Color.fromRGBO(29, 53, 87, 1)),
          elevation: 0,
          backgroundColor: color[0].white,
          title: Text(
            "Management Karyawan",
            style: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          ),
          actions: [
            IconButton(
                onPressed: () {
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
                              ]));
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        // drawer: DrawerHrd(),
        body: ContentHrd(),
      ),
    );
  }
}
