import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeStats extends StatefulWidget {
  const TimeStats({super.key});

  @override
  State<TimeStats> createState() => _TimeStatsState();
}

class _TimeStatsState extends State<TimeStats> {
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Date Range',
            style: TextStyle(fontSize: 15),
          ),
        ),
        TextField(
          controller: TextEditingController(
              text:
                  '${DateFormat('dd MMM yy').format(dateTimeRange.start)}  -  ${DateFormat('dd MMM yy').format(dateTimeRange.end)}'),
          readOnly: true,
          textAlign: TextAlign.center,
          onTap: () async {
            DateTimeRange? dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000));

            if (dateRange != null) {
              setState(() {
                dateTimeRange = dateRange;
              });
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Time Spent',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        
      ],
    );
  }
}
