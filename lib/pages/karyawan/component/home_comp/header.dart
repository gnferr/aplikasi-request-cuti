import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../provider/model/color_pallete.dart';

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
      child: Row(
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
          Stack(
            children: [
              Container(
                height: 120,
                width: 120,
                margin: EdgeInsets.only(left: 15, top: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color.fromRGBO(168, 218, 220, 1)),
              ),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color.fromRGBO(230, 57, 70, 1)),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, top: 8),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("${user!.photoURL}"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
