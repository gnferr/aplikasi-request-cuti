import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../provider/model/color_pallete.dart';

Widget statusRequest = StatusPending();

class KeteranganPengajuan extends StatelessWidget {
  const KeteranganPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    var userData = FirebaseAuth.instance.currentUser;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userData!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            //
            // Convert Timestamp Firebase to dd-MM-yyyy
            //
            final Timestamp timeStart =
                snapshot.data!['AjuanCuti']["cuti_start"] as Timestamp;
            final Timestamp timeEnd =
                snapshot.data!['AjuanCuti']["cuti_end"] as Timestamp;

            final DateTime dateStart = timeStart.toDate();
            final DateTime dateEnd = timeEnd.toDate();

            final cutiStart = DateFormat('dd-MM-yyyy').format(dateStart);
            final cutiEnd = DateFormat('dd-MM-yyyy').format(dateEnd);
            //
            // Conditional for Status Ajuan
            //
            if (snapshot.data!['AjuanCuti']['status'] == "pending") {
              statusRequest = StatusPending();
            } else if (snapshot.data!['AjuanCuti']['status'] == "accepted") {
              statusRequest = StatusAccepted();
            } else {
              statusRequest = StatusRejected();
            }

            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Status Pengajuan : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      statusRequest
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Jumlah Cuti : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(snapshot.data!['AjuanCuti']['getcuti'].toString() +
                          ' Hari')
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Dari Tanggal : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cutiStart.toString())
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Sampai Tanggal : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cutiEnd.toString())
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perihal Cuti : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.grey.shade100,
                          //     borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            snapshot.data!['AjuanCuti']['description'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class StatusPending extends StatelessWidget {
  const StatusPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellowAccent.shade700),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Text(
          'Pending',
          style: TextStyle(fontSize: 15, color: color[0].darkblue),
        )),
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
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 1, 166, 70)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Text(
          'Accepted',
          style: TextStyle(fontSize: 15, color: color[0].white),
        )),
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
          borderRadius: BorderRadius.circular(10), color: color[0].red),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Text(
          'Rejected',
          style: TextStyle(fontSize: 15, color: color[0].white),
        )),
      ),
    );
  }
}
