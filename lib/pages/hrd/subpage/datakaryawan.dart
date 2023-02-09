import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../provider/model/color_pallete.dart';

class DataKaryawan extends StatelessWidget {
  const DataKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color[0].darkblue),
        backgroundColor: color[0].white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('name', descending: false)
            .snapshots(),
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
                                'Data',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: color[0].darkblue),
                              ),
                              Text(
                                'Karyawan',
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
                              if (data['role'] == "karyawan") {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: BehindMotion(),
                                    children: [
                                      SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_forever,
                                          label: "Delete",
                                          onPressed: ((context) async {
                                            await FirebaseFirestore.instance
                                                .runTransaction((Transaction
                                                    myTransaction) async {
                                              await myTransaction.delete(
                                                  snapshot.data!.docs[index]
                                                      .reference);
                                            });
                                            const snackbar = SnackBar(
                                              content: Text(
                                                  'Berhasil Menghapus Data!'),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackbar);
                                          }))
                                    ],
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                            color: color[0].white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${data['name']}",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            color[0].darkblue),
                                                  ),
                                                  Text(
                                                    "${data['email']}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              data["AjuanCuti"]['cuti'] == 0
                                                  ? Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color: color[0].red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            "${data['AjuanCuti']['cuti']}",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: color[0]
                                                                    .white),
                                                          ),
                                                          Text(
                                                            "Hak Cuti",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: color[0]
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              color[0].darkblue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            "${data['AjuanCuti']['cuti']}",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: color[0]
                                                                    .white),
                                                          ),
                                                          Text(
                                                            "Hak Cuti",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: color[0]
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                            ],
                                          ),
                                        )),
                                  ),
                                );
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
          return Center(child: Text('No Data'));
        },
      ),
    );
  }
}

        //     StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return Container(
        //         color: color[0].grey,
        //         child: CustomScrollView(
        //           slivers: [
        //             SliverAppBar(
        //               iconTheme: IconThemeData(color: color[0].darkblue),
        //               backgroundColor: color[0].white,
        //               pinned: true,
        //               expandedHeight: 150.0,
        //               flexibleSpace: FlexibleSpaceBar(
        //                 title: Text(
        //                   'Data Karyawan',
        //                   style: TextStyle(
        //                       color: color[0].darkblue,
        //                       fontWeight: FontWeight.bold),
        //                   textScaleFactor: 1,
        //                 ),
        //               ),
        //             ),
        //             SliverToBoxAdapter(
        //               child: Container(
        //                 color: Colors.red,
        //               ),
        //             ),
        //             SliverList(
        //               delegate: SliverChildBuilderDelegate(
        //                 (_, int index) {
        //                   DocumentSnapshot data = snapshot.data!.docs[index];
        //                   return Stack(
        //                     children: [
        //                       Card(
        //                           shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(10)),
        //                           child: Container(
        //                             margin: EdgeInsets.only(top: 7),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(10),
        //                               color: Color.fromRGBO(230, 57, 70, 1),
        //                             ),
        //                             height: 80,
        //                           )),
        //                       Card(
        //                         shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(10)),
        //                         child: Container(
        //                             height: 80,
        //                             decoration: BoxDecoration(
        //                                 color: color[0].white,
        //                                 borderRadius: BorderRadius.circular(10)),
        //                             child: Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   Column(
        //                                     crossAxisAlignment:
        //                                         CrossAxisAlignment.start,
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.center,
        //                                     children: [
        //                                       Text(
        //                                         "${data['name']}",
        //                                         style: TextStyle(
        //                                             fontSize: 20,
        //                                             fontWeight: FontWeight.bold,
        //                                             color: color[0].darkblue),
        //                                       ),
        //                                       Text(
        //                                         "${data['email']}",
        //                                         style: TextStyle(
        //                                             color: Colors.grey,
        //                                             fontSize: 15),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   Container(
        //                                     height: 60,
        //                                     width: 60,
        //                                     decoration: BoxDecoration(
        //                                         color: color[0].darkblue,
        //                                         borderRadius:
        //                                             BorderRadius.circular(10)),
        //                                     child: Column(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.spaceAround,
        //                                       children: [
        //                                         Text(
        //                                           "${data['cuti']}",
        //                                           style: TextStyle(
        //                                               fontSize: 20,
        //                                               fontWeight: FontWeight.bold,
        //                                               color: color[0].white),
        //                                         ),
        //                                         Text(
        //                                           "Hak Cuti",
        //                                           style: TextStyle(
        //                                               fontSize: 13,
        //                                               color: color[0].white),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   )
        //                                 ],
        //                               ),
        //                             )),
        //                       ),
        //                     ],
        //                   );
        //                 },
        //                 childCount: snapshot.data!.docs.length,
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // )