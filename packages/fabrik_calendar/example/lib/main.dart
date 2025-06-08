import 'package:fabrik_calendar/fabrik_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FabrikCalendar(
          decoration: FCDayDecoration(
            todayTextColor: Colors.white,
            disableFutureDates: true,
            backgroundColor: Colors.grey.shade300,
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            todayBackgroundColor: Colors.pink,
            todayBorder: Border.all(
              color: Colors.purpleAccent,
              width: 6.0,
            ),
            disabledBackgroundColor: Colors.yellow.shade100,
            disabledTextColor: Colors.yellow.shade500,
            borderRadius: BorderRadius.circular(100),
            todayBorderRadius: BorderRadius.circular(2),
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            textColor: Colors.red,
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            todayTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            todayGradient: RadialGradient(colors: [
              Colors.pink.shade100,
              Colors.pink.shade500,
              Colors.pink.shade900,
            ]),
          ),
        ),
      ),
    );
  }
}
