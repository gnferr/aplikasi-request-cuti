import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../provider/model/color_pallete.dart';

class HeaderMainKaryawan extends StatefulWidget {
  const HeaderMainKaryawan({super.key});

  @override
  State<HeaderMainKaryawan> createState() => _HeaderMainKaryawanState();
}

class _HeaderMainKaryawanState extends State<HeaderMainKaryawan> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color[0].white,
      child: Column(
        children: [
          Text(
              DateFormat('EEEE, dd MMMM yyyy')
                  .format(DateTime.now())
                  .toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: color[0].darkblue)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome,",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: color[0].darkblue),
                  ),
                  Text(
                    "${user!.displayName}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: color[0].darkblue),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 65,
                backgroundColor: color[0].darkblue,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "https://media.vanityfair.fr/photos/60d3507cb5f615de15ffe813/16:9/w_2560%2Cc_limit/vf_ryan_gosling_9793.jpeg"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
