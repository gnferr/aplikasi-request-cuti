import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/pages/hrd/component/drawer.dart';
import 'package:tugas_akhir/provider/model/color_pallete.dart';

class BodyyPengajuanCuti extends StatefulWidget {
  BodyyPengajuanCuti({super.key});

  @override
  State<BodyyPengajuanCuti> createState() => _BodyyPengajuanCutiState();
}

class _BodyyPengajuanCutiState extends State<BodyyPengajuanCuti> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(2023, 02, 10),
  );

  @override
  Widget build(BuildContext context) {
    User? userNow = FirebaseAuth.instance.currentUser;

    DateTime cutiStart = dateRange.start;
    DateTime cutiEnd = dateRange.end;
    print(userNow);
    final startDate = dateRange.start;
    final endDate = dateRange.end;
    final dayRange = dateRange.duration;
    String nama = '';
    TextEditingController keterangan = TextEditingController();
    TextEditingController dateFrom =
        TextEditingController(text: DateFormat('dd-MM-yyyy').format(startDate));
    TextEditingController dateTo =
        TextEditingController(text: DateFormat('dd-MM-yyyy').format(endDate));
    TextEditingController hari =
        TextEditingController(text: dayRange.inDays.toString());
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userNow!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              nama = userNow.displayName.toString();
              final _nama = TextEditingController(text: nama);
              return Form(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nama,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelStyle: TextStyle(color: color[0].darkblue),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: color[0].darkblue),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        labelText: 'Nama',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: dateFrom,
                            showCursor: true,
                            keyboardType: TextInputType.none,
                            onTap: pickDateRange,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: color[0].darkblue),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: color[0].darkblue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.5),
                              ),
                              labelText: 'Date From',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            readOnly: true,
                            controller: dateTo,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              labelStyle: TextStyle(color: color[0].darkblue),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: color[0].darkblue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.5),
                              ),
                              labelText: 'Date To',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: hari,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              labelStyle: TextStyle(color: color[0].darkblue),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: color[0].darkblue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.5),
                              ),
                              labelText: 'Hari',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: keterangan,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: color[0].darkblue),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: color[0].darkblue),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        labelText: 'Keterangan',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Text("Are you sure?"),
                                content: Text("Anda yakin ingin mengirim? O_o"),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: color[0].red),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    onPressed: () async {
                                      CollectionReference data =
                                          FirebaseFirestore.instance
                                              .collection('users');
                                      await data.doc(userNow.uid).update({
                                        "getcuti": dayRange.inDays,
                                        "description": keterangan.text,
                                        "status": 'pending',
                                        "cuti_start": cutiStart,
                                        "cuti_end": cutiEnd
                                      });

                                      Navigator.pop(context);

                                      Future.delayed(
                                          Duration(seconds: 1),
                                          () => showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    content: SizedBox(
                                                      height: 100,
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                              'assets/images/check.png',
                                                              scale: 8),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              'Permohonan cuti berhasil terkirim!',
                                                              style: TextStyle(
                                                                  color: color[
                                                                          0]
                                                                      .darkblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))
                                                        ],
                                                      ),
                                                    ),
                                                  )));
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                            content: Center(
                                                child:
                                                    CircularProgressIndicator())),
                                      );
                                      Future.delayed(
                                          Duration(milliseconds: 800),
                                          () => Navigator.pop(context));
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: color[0].darkblue,
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: Text('Submit')),
                    )
                  ],
                ),
              ));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2099),
        initialDateRange: dateRange);
    if (newDateRange == null) {
      return;
    } else {
      if (newDateRange == DateTime.saturday ||
          newDateRange == DateTime.sunday) {
        print('cannot select tanggal merah');
        return;
      } else {
        setState(() {
          dateRange = newDateRange;
        });
      }
    }
  }
}
