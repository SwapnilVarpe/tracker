import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TimeSchedule extends ConsumerWidget {
  const TimeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hours = _hours();
    return ScrollablePositionedList.builder(
        itemCount: hours.length,
        itemBuilder: (context, index) {
          // onTap: () => context.go('/new-time-entry'),
          return SizedBox(
              height: 60,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 75,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat('hh:mm a').format(hours[index]),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        )),
                    Expanded(
                        child: Card(
                      child: InkWell(
                        onTap: () {
                          context.go('/new-time-entry');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Text(
                                'Planned',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Line 2',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Line 3',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Card(
                      child: InkWell(
                        onTap: () {
                          context.go('/new-time-entry');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Text(
                                'Actual',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Line 2',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Line 3',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ]));
        });
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
