import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/pages/hrd/component/drawer.dart';
import 'package:tugas_akhir/pages/hrd/component/hrdcontent.dart';
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
        ),
        drawer: DrawerHrd(),
        body: ContentHrd(),
      ),
    );
  }
}
