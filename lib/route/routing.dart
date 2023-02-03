import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tugas_akhir/pages/auth/loginpage.dart';
import 'package:tugas_akhir/pages/auth/register.dart';
import 'package:tugas_akhir/pages/hrd/mainhrd.dart';
import 'package:tugas_akhir/pages/hrd/subpage/approval_page.dart';
import 'package:tugas_akhir/pages/hrd/subpage/datakaryawan.dart';
import 'package:tugas_akhir/pages/kalender/kalender.dart';
import 'package:tugas_akhir/pages/karyawan/mainkaryawan.dart';
import 'package:tugas_akhir/pages/karyawan/subpage/detail_karyawan.dart';
import 'package:tugas_akhir/pages/karyawan/subpage/pengajuan_cuti.dart';

class AppRoute {
  GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: "/login",
        name: 'login',
        builder: (context, state) {
          return MainLogin();
        },
      ),
      GoRoute(
        path: "/register",
        name: 'register',
        builder: (context, state) {
          return MainRegister();
        },
      ),
      GoRoute(
          path: "/karyawan",
          name: 'karyawan',
          builder: (context, state) {
            return MainKaryawan();
          },
          routes: [
            GoRoute(
              name: "detailKaryawan",
              path: "detail",
              builder: (context, state) => const InformasiSaya(),
            ),
            GoRoute(
              name: "kalender",
              path: "calendar",
              builder: (context, state) => const Kalender(),
            ),
            GoRoute(
              name: "pengajuancuti",
              path: "pengajuancuti",
              builder: (context, state) => PengajuanCuti(),
            ),
          ]),
      GoRoute(
          path: "/hrd",
          name: 'hrd',
          builder: (context, state) {
            return const MainHrd();
          },
          routes: [
            GoRoute(
              name: "datakaryawan",
              path: "datakaryawan",
              builder: (context, state) => const DataKaryawan(),
            ),
            GoRoute(
              name: "cutiapproval",
              path: "cutiapproval",
              builder: (context, state) => ApprovalPage(),
            ),
            GoRoute(
              name: "calendar",
              path: "calendar",
              builder: (context, state) => const Kalender(),
            ),
          ]),
    ],
    initialLocation: "/login",
    routerNeglect: true,
  );
}
