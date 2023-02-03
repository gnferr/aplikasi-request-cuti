import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/kalender/calendar/body_calendar.dart';
import 'package:tugas_akhir/pages/kalender/calendar/header.dart';

import '../../provider/model/color_pallete.dart';

class Kalender extends StatelessWidget {
  const Kalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color[0].darkblue),
        backgroundColor: color[0].white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(flex: 1, child: HeaderCalendar()),
            Expanded(flex: 4, child: BodyCalendar())
          ],
        ),
      ),
    );
  }
}
