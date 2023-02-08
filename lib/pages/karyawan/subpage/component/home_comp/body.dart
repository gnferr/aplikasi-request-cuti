import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../provider/model/color_pallete.dart';

class MainMenuKaryawan extends StatelessWidget {
  MainMenuKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: color[0].white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              direction: Axis.horizontal,
              runSpacing: 20,
              children: [
                InkWell(
                  onTap: () async {
                    context.goNamed('detailKaryawan');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        color: color[0].white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/users.png',
                            scale: 3,
                            color: color[0].darkblue,
                          ),
                          Text(
                            'Informasi Saya',
                            style: TextStyle(
                                color: color[0].darkblue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    context.goNamed('pengajuancuti');
                  }),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        color: color[0].white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/email.png',
                            scale: 3,
                            color: color[0].darkblue,
                          ),
                          Text(
                            'Pengajuan Cuti',
                            style: TextStyle(
                                color: color[0].darkblue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    context.goNamed('kalender');
                  }),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        color: color[0].white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/calendar.png',
                            scale: 3,
                            color: color[0].darkblue,
                          ),
                          Text(
                            'Kalender',
                            style: TextStyle(
                                color: color[0].darkblue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
