import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/pages/karyawan/subpage/component/ajuancuti/history.dart';

import '../../../provider/model/color_pallete.dart';
import 'component/ajuancuti/bodyy.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({super.key});

  @override
  State<PengajuanCuti> createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  @override
  Widget build(BuildContext context) {
    var userData = FirebaseAuth.instance.currentUser;
    CollectionReference userCuti =
        FirebaseFirestore.instance.collection('users');
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
              //
              // IF CUTI_END == DATE NOW // masa cuti berakhir //
              //
              Timestamp cutiEnd =
                  snapshot.data!['AjuanCuti']['cuti_end'] as Timestamp;
              DateTime cutiEndFix = cutiEnd.toDate();
              final cutiEndFixFix = DateFormat('dd-MM-yyyy').format(cutiEndFix);
              final dateTimeNow =
                  DateFormat('dd-MM-yyyy').format(DateTime.now());
              // Testing //
              print("${dateTimeNow} + DateTime");
              print("${cutiEndFixFix} + CutiEndFix");
              // ======= //
              if (cutiEndFixFix == dateTimeNow) {
                userCuti.doc(userData.uid).update({
                  "AjuanCuti.getcuti": 0,
                  "AjuanCuti.description": "",
                  "AjuanCuti.status": "pending",
                  "AjuanCuti.cuti_start": DateTime.now(),
                  "AjuanCuti.cuti_end": DateTime.now().add(Duration(days: 1)),
                });
              }
              //===========END===========//
              return Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      snapshot.data!['AjuanCuti']['getcuti'] > 0
                          ? Container(
                              height: MediaQuery.of(context).size.height / 5.2,
                              width: MediaQuery.of(context).size.width,
                              child: KeteranganPengajuan())
                          : Container(),
                      Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                          width: MediaQuery.of(context).size.width,
                          child: BodyyPengajuanCuti()),
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
