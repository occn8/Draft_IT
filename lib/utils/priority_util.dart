import 'package:flutter/material.dart';

Color getPriorityColor(int priority) {
    switch (priority) {
      case 0:
        return Colors.lime;
        break;
      case 1:
        return Colors.orangeAccent;
        break;
      case 2:
        return Color(0xfffa5b5d);
        break;
      default:
        return Colors.orangeAccent;
    }
  }