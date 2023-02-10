import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/pages/hrd/subpage/component/drawer.dart';
import 'package:tugas_akhir/provider/model/color_pallete.dart';

class BodyyPengajuanCuti extends StatefulWidget {
  BodyyPengajuanCuti({super.key});

  @override
  State<BodyyPengajuanCuti> createState() => _BodyyPengajuanCutiState();
}

class _BodyyPengajuanCutiState extends State<BodyyPengajuanCuti> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 2)),
  );

  @override
  Widget build(BuildContext context) {
    User? userNow = FirebaseAuth.instance.currentUser;
    String nama = '';
    //
    // Convert Timestamp to dd-MM-yyyy , for controller view TextFormField
    //
    DateTime cutiStart = dateRange.start;
    DateTime cutiEnd = dateRange.end;
    print(userNow);
    final startDate = dateRange.start;
    final endDate = dateRange.end;
    final dayRange = dateRange.duration;
    TextEditingController keterangan = TextEditingController();
    TextEditingController dateFrom =
        TextEditingController(text: DateFormat('dd-MM-yyyy').format(startDate));
    TextEditingController dateTo =
        TextEditingController(text: DateFormat('dd-MM-yyyy').format(endDate));
    TextEditingController hari =
        TextEditingController(text: dayRange.inDays.toString());
    //
    //
    return StreamBuilder<DocumentSnapshot>(
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
                          borderSide:
                              BorderSide(width: 1.5, color: color[0].darkblue),
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
                          borderSide:
                              BorderSide(width: 1.5, color: color[0].darkblue),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      labelText: 'Perihal Cuti',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Column(
                      children: [
                        if (snapshot.data!['AjuanCuti']['cuti'] == 0) ...[
                          ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: Column(
                                            children: [
                                              Text("Warning!",
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Image.network(
                                                'https://cdn-icons-png.flaticon.com/512/595/595067.png',
                                                scale: 8,
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              "Hak Cuti anda telah habis!"),
                                        ));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: color[0].darkblue,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text('Submit'))
                        ] else if (dateRange.duration.inDays >
                            snapshot.data!['AjuanCuti']['cuti']) ...[
                          ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: Column(
                                            children: [
                                              Text("Warning!",
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Image.network(
                                                'https://cdn-icons-png.flaticon.com/512/595/595067.png',
                                                scale: 8,
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              "Pengajuan Cuti Tidak bisa lebih besar dari sisa cuti anda!"),
                                        ));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: color[0].darkblue,
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text('Submit'))
                        ] else ...[
                          snapshot.data!['AjuanCuti']['status'] == 'accepted'
                              ? ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                              title: Column(
                                                children: [
                                                  const Text("Warning!",
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  Image.network(
                                                    'https://cdn-icons-png.flaticon.com/512/595/595067.png',
                                                    scale: 8,
                                                  ),
                                                ],
                                              ),
                                              content: const Text(
                                                  "Izin Cuti Sedang Berlangsung!"),
                                            ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: color[0].darkblue,
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Text('Submit'))
                              : ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => CupertinoAlertDialog(
                                                title: Text("Are you sure?"),
                                                content: Text(
                                                    "Anda yakin ingin mengirim? O_o"),
                                                actions: <Widget>[
                                                  CupertinoDialogAction(
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .red.shade700),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .green.shade700),
                                                    ),
                                                    onPressed: () async {
                                                      CollectionReference data =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users');
                                                      await data
                                                          .doc(userNow.uid)
                                                          .update({
                                                        "AjuanCuti.getcuti":
                                                            dayRange.inDays,
                                                        "AjuanCuti.description":
                                                            keterangan.text,
                                                        "AjuanCuti.status":
                                                            'pending',
                                                        "AjuanCuti.cuti_start":
                                                            cutiStart,
                                                        "AjuanCuti.cuti_end":
                                                            cutiEnd
                                                      });

                                                      const snackbar = SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                            'Pengajuan Cuti Success Terkirim!'),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackbar);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ]));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: color[0].darkblue,
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Text('Submit')),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ));
          }
          return Center(child: CircularProgressIndicator());
        });
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
      if (newDateRange.start.weekday == DateTime.sunday ||
          newDateRange.end.weekday == DateTime.sunday ||
          newDateRange.start.weekday == DateTime.saturday ||
          newDateRange.end.weekday == DateTime.saturday) {
        print("Libur Ga bisa cuti cuy");
        return showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: Column(
                    children: [
                      Text("Warning!", style: TextStyle(fontSize: 20)),
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/595/595067.png',
                        scale: 8,
                      ),
                    ],
                  ),
                  content: Text("Pengajuan Cuti hanya berlaku Senin - Jum'at"),
                ));
      } else {
        if (newDateRange.duration.inDays > 12) {
          print('gabisa');
          return showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Column(
                      children: [
                        Text("Warning!", style: TextStyle(fontSize: 20)),
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/595/595067.png',
                          scale: 8,
                        ),
                      ],
                    ),
                    content: Text("Melebihi Batas Maximum Pengajuan!"),
                  ));
        } else {
          setState(() {
            dateRange = newDateRange;
          });
        }
      }
    }
  }
}
