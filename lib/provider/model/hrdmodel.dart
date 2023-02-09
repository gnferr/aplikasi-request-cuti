import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/hrd/subpage/approval_page.dart';
import 'package:tugas_akhir/pages/hrd/subpage/datakaryawan.dart';
import 'package:tugas_akhir/pages/hrd/subpage/home.dart';

// Model Drawer HRD // untuk sekarang ga ada guna
class HrdItem {
  IconData icons;
  String title;
  String routes;
  Widget page;
  HrdItem(
      {required this.icons,
      required this.title,
      required this.routes,
      required this.page});
}

List<HrdItem> menuDrawer = [
  HrdItem(icons: Icons.home, title: 'Home', routes: 'hrd', page: HomeHrd()),
  HrdItem(
      icons: Icons.supervisor_account,
      title: 'Data Karyawan',
      routes: 'datakaryawan',
      page: DataKaryawan()),
  HrdItem(
      icons: Icons.assignment,
      title: 'Cuti Approval',
      routes: 'datacuti',
      page: ApprovalPage()),
];
