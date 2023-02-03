import 'package:flutter/material.dart';

import '../../../../provider/model/color_pallete.dart';

class HeaderPengajuanCuti extends StatelessWidget {
  const HeaderPengajuanCuti({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color[0].white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengajuan',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: color[0].darkblue),
                ),
                Text(
                  'Cuti',
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
    );
  }
}
