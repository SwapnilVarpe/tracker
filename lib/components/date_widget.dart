import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnSelected = void Function(DateTime date);

class DateWidget extends StatelessWidget {
  const DateWidget(
      {super.key,
      this.width = 70,
      required this.date,
      required this.color,
      required this.onSelected});

  final double width;
  final DateTime date;
  final Color color;
  final OnSelected onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onSelected.call(date),
        child: Container(
          width: width,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: color),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(DateFormat("MMM").format(date).toUpperCase(), // Month
                    style: const TextStyle(fontSize: 10)),
                Text(date.day.toString(), // Date
                    style: const TextStyle(fontSize: 20)),
                Text(DateFormat("E").format(date).toUpperCase(), // WeekDay
                    style: const TextStyle(fontSize: 10))
              ],
            ),
          ),
        ));
  }
}
