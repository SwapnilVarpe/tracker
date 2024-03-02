import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracker/components/basic_slider.dart';
import 'package:tracker/components/date_widget.dart';
import 'package:tracker/providers/time_schedule_provider.dart';

class TimeSchedule extends ConsumerWidget {
  final int initialIndex = DateTime.now().hour;

  TimeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    var day = ref.watch(dayProvider);
    var hours = _hours();
    return Column(
      children: [
        const SizedBox(
          height: 30,
          child: Row(children: [
            SizedBox(
                width: 75,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child:
                      Align(alignment: Alignment.center, child: Text('Time')),
                )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Align(alignment: Alignment.center, child: Text('Planned')),
            )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Align(alignment: Alignment.center, child: Text('Actual')),
            )),
          ]),
        ),
        Expanded(
          child: ScrollablePositionedList.builder(
              initialScrollIndex: initialIndex,
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
              }),
        ),
        BasicSlider<DateTime>(
          firstState: DateTime.now().subtract(const Duration(days: 1)),
          numOfItem: 3,
          selectedItem: day,
          itemBuiler: (value) => DateWidget(
              date: value,
              onSelected: (date) => ref.read(dayProvider.notifier).state = date,
              color: DateUtils.isSameDay(day, value)
                  ? colorScheme.secondaryContainer
                  : Colors.transparent),
          nextItem: (value) => value.add(const Duration(days: 1)),
          prevItem: (value) => value.subtract(const Duration(days: 1)),
        )
      ],
    );
  }

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
