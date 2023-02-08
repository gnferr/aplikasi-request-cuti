import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tugas_akhir/provider/model/color_pallete.dart';

class ListMenuHrd extends StatelessWidget {
  const ListMenuHrd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: color[0].white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            runSpacing: 10,
            children: [
              InkWell(
                onTap: () async {
                  context.goNamed('datakaryawan');
                },
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.deepPurple, Colors.blueAccent]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                            'assets/images/user_group.png',
                            scale: 12,
                            color: color[0].darkblue,
                          ),
                        ),
                        Text(
                          'Data Karyawan',
                          style: TextStyle(
                              color: color[0].white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  context.goNamed('cutiapproval');
                },
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.blueAccent, Colors.deepPurple]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                            'assets/images/checklist.png',
                            scale: 12,
                            color: color[0].darkblue,
                          ),
                        ),
                        Text(
                          'Cuti Approval',
                          style: TextStyle(
                              color: color[0].white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  context.goNamed('calender');
                },
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blueAccent, Colors.deepPurple]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                            'assets/images/calendar.png',
                            scale: 12,
                            color: color[0].darkblue,
                          ),
                        ),
                        Text(
                          'Kalender',
                          style: TextStyle(
                              color: color[0].white,
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
    );
  }
}
