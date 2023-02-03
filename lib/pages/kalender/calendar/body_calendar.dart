import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tugas_akhir/provider/service/hrd_service.dart';

import '../../../provider/model/color_pallete.dart';

class BodyCalendar extends StatefulWidget {
  BodyCalendar({super.key});

  @override
  State<BodyCalendar> createState() => _BodyCalendarState();
}

class _BodyCalendarState extends State<BodyCalendar> {
  DateTime today = DateTime.now();

  void _selectedDay(DateTime day, DateTime onfocusedDay) {
    setState(() {
      today = day;
    });
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
          child: TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.red.shade400)),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red.shade400)),
            weekendDays: [DateTime.sunday],
            locale: "en_US",
            headerStyle: HeaderStyle(
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
        ),
      ),
    );
  }
}
