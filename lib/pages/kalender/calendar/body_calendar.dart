import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tugas_akhir/pages/kalender/kalender_service.dart';
import 'package:tugas_akhir/provider/service/hrd_service.dart';

import '../../../provider/model/color_pallete.dart';

class BodyCalendar extends StatefulWidget {
  BodyCalendar({super.key});
  @override
  State<BodyCalendar> createState() => _BodyCalendarState();
}

DateTime today = DateTime.now();

Map<DateTime, List<HariLibur>> getEvent = {};

Future<void> gettData() async {
  final respose =
      await http.get(Uri.parse('https://api-harilibur.vercel.app/api'));

  List<dynamic> data = jsonDecode(respose.body);
  for (int i = 0; i < data.length; i++) {
    if (data.isNotEmpty) {
      if (data[i]['is_national_holiday'] == true) {
        if (data[i]['holiday_date'].length == 9) {
          var time = data[i]['holiday_date'].substring(0, 8) +
              '0' +
              data[i]['holiday_date'].substring(8, 9);
          today = DateTime.parse(time + " 07:00:00.000").toUtc();
        } else {
          today =
              DateTime.parse(data[i]['holiday_date'] + " 07:00:00.000").toUtc();
        }

        HariLibur libur = HariLibur(
            holidayDate: data[i]['holiday_date'],
            holidayName: data[i]['holiday_name'],
            isNationalHoliday: data[i]['is_national_day']);
        getEvent[today] = [libur];
      }
    }
  }
}

class _BodyCalendarState extends State<BodyCalendar> {
  List<HariLibur> _getEventDate(DateTime date) {
    return getEvent[date] ?? [];
  }

  void _selectedDay(DateTime day, DateTime onfocusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color[0].grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: color[0].white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              TableCalendar(
                eventLoader: _getEventDate,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                    weekendTextStyle: TextStyle(color: Colors.red.shade400)),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red.shade400)),
                weekendDays: [DateTime.sunday],
                locale: "en_US",
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                selectedDayPredicate: (day) => isSameDay(day, today),
                availableGestures: AvailableGestures.all,
                focusedDay: today,
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 12),
                onDaySelected: _selectedDay,
              ),
              ..._getEventDate(today).map((HariLibur libur) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("${libur.holidayDate} : ",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(libur.holidayName),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
