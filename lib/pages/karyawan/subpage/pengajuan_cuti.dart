import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/karyawan/component/ajuancuti/body.dart';
import 'package:tugas_akhir/pages/karyawan/component/ajuancuti/header.dart';
import 'package:tugas_akhir/pages/karyawan/component/ajuancuti/history.dart';

import '../../../provider/model/color_pallete.dart';
import '../component/ajuancuti/bodyy.dart';

class PengajuanCuti extends StatelessWidget {
  const PengajuanCuti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: color[0].darkblue),
        backgroundColor: color[0].white,
        title: Text(
          "Pengajuan Cuti",
          style: TextStyle(color: color[0].darkblue),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userData!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // Container(
                      //     height: MediaQuery.of(context).size.height / 5.5,
                      //     width: MediaQuery.of(context).size.width,
                      //     child: HeaderPengajuanCuti()),
                      snapshot.data!['getcuti'] > 0
                          ? Container(
                              height: MediaQuery.of(context).size.height / 5.2,
                              width: MediaQuery.of(context).size.width,
                              child: KeteranganPengajuan())
                          : Container(),
                      Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: BodyyPengajuanCuti()),
                      // Expanded(flex: 2, child: HistoryPengajuanCuti()),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
