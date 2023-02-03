import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../provider/model/color_pallete.dart';

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  Widget status = const StatusRejected();

  @override
  Widget build(BuildContext context) {
    CollectionReference listcuti =
        FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color[0].darkblue),
        backgroundColor: color[0].white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: color[0].white,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cuti',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: color[0].darkblue),
                              ),
                              Text(
                                'Approval',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: color[0].darkblue),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        color: color[0].grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              final Timestamp timeStart =
                                  data["cuti_start"] as Timestamp;
                              final Timestamp timeEnd =
                                  data["cuti_end"] as Timestamp;

                              final DateTime dateStart = timeStart.toDate();
                              final DateTime dateEnd = timeEnd.toDate();

                              final cutiStart =
                                  DateFormat('dd-MM-yyyy').format(dateStart);
                              final cutiEnd =
                                  DateFormat('dd-MM-yyyy').format(dateEnd);

                              final totalCuti = data['getcuti'];

                              if (data['status'] == "pending") {
                                status = StatusPending();
                              } else if (data['status'] == "accepted") {
                                status = StatusAccepted();
                              } else {
                                status = StatusRejected();
                              }
                              if (data['role'] == 'karyawan') {
                                if (data['getcuti'] != 0) {
                                  return Stack(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            margin: EdgeInsets.only(top: 7),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromRGBO(
                                                  230, 57, 70, 1),
                                            ),
                                            height: 80,
                                          )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                            height: 140,
                                            decoration: BoxDecoration(
                                                color: color[0].white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            // "${data['name']}",
                                                            "${data['name']}",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: color[0]
                                                                    .darkblue),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          status
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        "Start: ${cutiStart}  End: ${cutiEnd} ",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        "Jumlah Cuti: ${data['getcuti']} Hari",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: color[0].grey,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            '${data['description']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 110,
                                                    child: data['status'] ==
                                                                'accepted' ||
                                                            data['status'] ==
                                                                'rejected'
                                                        ? Container()
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (ctx) =>
                                                                              AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        title: Text(
                                                                            "Are you sure?"),
                                                                        content:
                                                                            Text("Anda akan menolak pengajuan cuti ini!"),
                                                                        actions: <
                                                                            Widget>[
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: color[0].red),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text("Cancel"),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                                            onPressed:
                                                                                () async {
                                                                              await listcuti.doc(data.id).update({
                                                                                "status": "rejected"
                                                                              });
                                                                              Navigator.of(ctx).pop();
                                                                              Future.delayed(
                                                                                  Duration(seconds: 1),
                                                                                  () => showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => AlertDialog(
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                            ),
                                                                                            content: SizedBox(
                                                                                              height: 100,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Image.asset('assets/images/cancel.png', scale: 8),
                                                                                                  SizedBox(
                                                                                                    height: 10,
                                                                                                  ),
                                                                                                  Text('Berhasil menolak permohonan cuti!', style: TextStyle(color: color[0].darkblue, fontWeight: FontWeight.w500))
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          )));
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) => AlertDialog(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    elevation: 0,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    content: Center(child: CircularProgressIndicator())),
                                                                              );
                                                                              Future.delayed(Duration(milliseconds: 800), () => Navigator.pop(context));
                                                                            },
                                                                            child:
                                                                                Text("OK"),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Image.asset(
                                                                      'assets/images/cancel.png',
                                                                      scale:
                                                                          11),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (ctx) =>
                                                                              AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        title: Text(
                                                                            "Are you sure?"),
                                                                        content:
                                                                            Text("Anda akan menerima pengajuan cuti ini!"),
                                                                        actions: <
                                                                            Widget>[
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: color[0].red),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(ctx).pop();
                                                                            },
                                                                            child:
                                                                                Text("Cancel"),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                                            onPressed:
                                                                                () async {
                                                                              await listcuti.doc(data.id).update({
                                                                                "status": "accepted",
                                                                                "cuti": FieldValue.increment(-totalCuti)
                                                                              });
                                                                              Navigator.of(ctx).pop();

                                                                              Future.delayed(
                                                                                  Duration(seconds: 1),
                                                                                  () => showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => AlertDialog(
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                            ),
                                                                                            content: SizedBox(
                                                                                              height: 100,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Image.asset('assets/images/check.png', scale: 8),
                                                                                                  SizedBox(
                                                                                                    height: 10,
                                                                                                  ),
                                                                                                  Text('Berhasil menerima permohonan cuti!', style: TextStyle(color: color[0].darkblue, fontWeight: FontWeight.w500))
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          )));
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) => AlertDialog(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    elevation: 0,
                                                                                    backgroundColor: Colors.transparent,
                                                                                    content: Center(child: CircularProgressIndicator())),
                                                                              );
                                                                              Future.delayed(Duration(milliseconds: 800), () => Navigator.pop(context));
                                                                            },
                                                                            child:
                                                                                Text("OK"),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Image.asset(
                                                                      'assets/images/check.png',
                                                                      scale:
                                                                          11),
                                                                ),
                                                              ]),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      )),
                ],
              ),
            );
          }
          return Center(child: Text("No Data"));
        },
      ),
    );
  }
}

class StatusPending extends StatelessWidget {
  const StatusPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.yellowAccent.shade700),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "Pending",
          style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: color[0].white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class StatusAccepted extends StatelessWidget {
  const StatusAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.greenAccent.shade700),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "Accepted",
          style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: color[0].white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class StatusRejected extends StatelessWidget {
  const StatusRejected({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.red.shade800),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "Rejected",
          style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: color[0].white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
