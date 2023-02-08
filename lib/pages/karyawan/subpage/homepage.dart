import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/karyawan/subpage/component/home_comp/header.dart';
import 'package:tugas_akhir/pages/karyawan/subpage/component/home_comp/body.dart';

class HomeKaryawan extends StatelessWidget {
  const HomeKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: HeaderMainKaryawan()),
          Expanded(flex: 3, child: MainMenuKaryawan())
        ],
      ),
    );
  }
}
