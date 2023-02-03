import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/pages/auth/register.dart';
import 'package:tugas_akhir/pages/hrd/component/drawer.dart';
import 'package:tugas_akhir/pages/karyawan/component/ajuancuti/body.dart';

import '../../../../provider/model/color_pallete.dart';

// class HistoryPengajuanCuti extends StatefulWidget {
//   const HistoryPengajuanCuti({super.key});

//   @override
//   State<HistoryPengajuanCuti> createState() => _HistoryPengajuanCutiState();
// }

// class _HistoryPengajuanCutiState extends State<HistoryPengajuanCuti> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       color: color[0].white,
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               'History',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: color[0].darkblue),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 3.2,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: color[0].grey,
//               ),
//               child: StreamBuilder<DocumentSnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(userData!.uid)
//                       .snapshots(),
//                   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                     if (snapshot.hasData) {
//                       print(userData!.uid);
//                       print(snapshot.data!['name']);

//                       return Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Container(
//                               height: MediaQuery.of(context).size.height / 2,
//                               decoration: BoxDecoration(
//                                   color: color[0].white,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "${snapshot.data!['name']}",
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                               color: color[0].darkblue),
//                                         ),
//                                         SizedBox(
//                                           height: 3,
//                                         ),
//                                         Text(
//                                           "Date: 20-03-2023  Cuti:${snapshot.data!['getcuti']}",
//                                           style: TextStyle(
//                                               color: Colors.grey, fontSize: 15),
//                                         ),
//                                         SizedBox(
//                                           height: 3,
//                                         ),
//                                         Container(
//                                           height: 50,
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               2,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             color: color[0].grey,
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               '${snapshot.data!['description']}',
//                                               overflow: TextOverflow.clip,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     statusRequest
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       );
//                     }
//                     return Center(child: Text('No Data'));
//                   }),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
Widget statusRequest = StatusPending();
var userData = FirebaseAuth.instance.currentUser;

class KeteranganPengajuan extends StatelessWidget {
  const KeteranganPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userData!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final Timestamp timeStart =
                snapshot.data!["cuti_start"] as Timestamp;
            final Timestamp timeEnd = snapshot.data!["cuti_end"] as Timestamp;

            final DateTime dateStart = timeStart.toDate();
            final DateTime dateEnd = timeEnd.toDate();

            final cutiStart = DateFormat('dd-MM-yyyy').format(dateStart);
            final cutiEnd = DateFormat('dd-MM-yyyy').format(dateEnd);
            if (snapshot.data!['status'] == "pending") {
              statusRequest = StatusPending();
            } else if (snapshot.data!['status'] == "accepted") {
              statusRequest = StatusAccepted();
            } else {
              statusRequest = StatusRejected();
            }

            return Padding(
              padding: EdgeInsets.all(10),
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
                      Text(snapshot.data!['getcuti'].toString() + ' Hari')
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
                        width: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Sampai Tanggal : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cutiStart.toString())
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
                        'Deskripsi : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5)),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            snapshot.data!['description'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                  Divider()
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
