import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TimeSchedule extends ConsumerWidget {
  const TimeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hours = _hours();
    return ScrollablePositionedList.builder(
      itemCount: hours.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          onTap: () => context.go('/new-time-entry'),
          leading: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                DateFormat('hh:mm a').format(hours[index]),
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ));
      },
    );
  }

  // Widget hourCard(List<DateTime> hours, int index) {
  //   return Card(
  //       child: ListTile(
  //     onTap: () => context.go('/new-time-entry'),
  //     leading: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Text(
  //           DateFormat('hh:mm a').format(hours[index]),
  //           style: TextStyle(fontSize: 15),
  //         ),
  //       ],
  //     ),
  //   ));
  // }

  List<DateTime> _hours() {
    List<DateTime> list = [];
    var now = DateTime.now();
    var timeCounter = DateTime(now.year, now.month, now.day, 0, 0, 0);
    for (int hour = 0; hour <= 24; hour++) {
      list.add(timeCounter);
      timeCounter = timeCounter.add(const Duration(hours: 1));
    }
    return list;
  }
}
