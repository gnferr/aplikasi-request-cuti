import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/hrd/component/home_comp/list_menu.dart';
import 'package:tugas_akhir/pages/hrd/component/home_comp/welcome.dart';

class HomeHrd extends StatefulWidget {
  HomeHrd({super.key});

  @override
  State<HomeHrd> createState() => _HomeHrdState();
}

FirebaseAuth user = FirebaseAuth.instance;
var userdata = user.currentUser;

class _HomeHrdState extends State<HomeHrd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: WelcomeHRD()),
          Expanded(flex: 2, child: ListMenuHrd())
        ],
      ),
    );
  }
}
