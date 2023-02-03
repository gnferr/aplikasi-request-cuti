import 'package:flutter/material.dart';

import '../../../provider/model/color_pallete.dart';

class HeaderCalendar extends StatelessWidget {
  const HeaderCalendar({super.key});

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
                  'Event',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: color[0].darkblue),
                ),
                Text(
                  'Calendar',
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
