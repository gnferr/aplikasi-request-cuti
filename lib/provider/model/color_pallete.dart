import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Model Colors // sedikit ada guna
class ColorPallete {
  Color red;
  Color white;
  Color cyan;
  Color blue;
  Color darkblue;
  Color grey;
  ColorPallete({
    required this.red,
    required this.white,
    required this.cyan,
    required this.blue,
    required this.darkblue,
    required this.grey,
  });
}

List<ColorPallete> color = [
  ColorPallete(
      red: const Color.fromRGBO(230, 57, 70, 1),
      white: const Color.fromARGB(255, 255, 255, 255),
      cyan: const Color.fromRGBO(168, 218, 220, 1),
      blue: const Color.fromRGBO(69, 123, 157, 1),
      darkblue: const Color.fromRGBO(29, 53, 87, 1),
      grey: Colors.grey.shade200)
];
