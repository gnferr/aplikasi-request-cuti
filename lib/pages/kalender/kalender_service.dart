import 'dart:convert';

import 'package:http/http.dart' as http;

class HariLibur {
  final holidayDate;
  final holidayName;
  final isNationalHoliday;

  HariLibur(
      {required this.holidayDate,
      required this.holidayName,
      required this.isNationalHoliday});

  factory HariLibur.fromJson(Map<String, dynamic> json) {
    return HariLibur(
        holidayDate: json['holiday_date'],
        holidayName: json['holiday_name'],
        isNationalHoliday: json['is_national_holiday']);
  }
}
