import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../provider/model/color_pallete.dart';

class BodyDetail extends StatefulWidget {
  const BodyDetail({super.key});

  @override
  State<BodyDetail> createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.12,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  final name =
                      TextEditingController(text: snapshot.data!['name']);
                  final email =
                      TextEditingController(text: snapshot.data!['email']);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      color: color[0].white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: color[0].red,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 11, left: 11),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: color[0].cyan,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, left: 5),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage("${user.photoURL}"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: name,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor: Colors.grey.shade200,
                                              labelStyle: TextStyle(
                                                  color: color[0].darkblue),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: color[0].darkblue),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 1.5),
                                              ),
                                              labelText: 'Nama Lengkap',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: email,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              fillColor: Colors.grey.shade200,
                                              labelStyle: TextStyle(
                                                  color: color[0].darkblue),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: color[0].darkblue),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 1.5),
                                              ),
                                              labelText: 'Email',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      color: color[0].darkblue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(snapshot.data!['cuti'].toString(),
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: color[0].white)),
                                        Text('Hak Cuti',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: color[0].grey))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ColumInputan()
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}

class ColumInputan extends StatefulWidget {
  ColumInputan({super.key});

  @override
  State<ColumInputan> createState() => _ColumInputanState();
}

class _ColumInputanState extends State<ColumInputan> {
  @override
  Widget build(BuildContext context) {
    User? user1 = FirebaseAuth.instance.currentUser;
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user1!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          TextEditingController noHp = TextEditingController();
          TextEditingController alamat = TextEditingController();

          return Form(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      labelStyle: TextStyle(color: color[0].darkblue),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: color[0].darkblue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5),
                      ),
                      labelText: 'NIK',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: noHp,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(color: color[0].darkblue),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: color[0].darkblue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5),
                      ),
                      labelText: 'No Handphone',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: alamat,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: color[0].darkblue),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: color[0].darkblue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5),
                      ),
                      labelText: 'Alamat',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.save),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Save Changes',
                                style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }
}
