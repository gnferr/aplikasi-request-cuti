import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/karyawan/component/detail/body.dart';
import 'package:tugas_akhir/pages/karyawan/component/detail/header.dart';

import '../../../provider/model/color_pallete.dart';

class InformasiSaya extends StatelessWidget {
  const InformasiSaya({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Informasi Saya',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: color[0].darkblue)),
          iconTheme: IconThemeData(color: color[0].darkblue),
          backgroundColor: color[0].white,
          elevation: 0,
        ),
        body: BodyDetail());
  }
}
