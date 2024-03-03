import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracker/components/basic_slider.dart';
import 'package:tracker/components/date_widget.dart';
import 'package:tracker/modal/activity.dart';
import 'package:tracker/providers/time_schedule_provider.dart';

class TimeSchedule extends ConsumerWidget {
  final int initialIndex = DateTime.now().hour;
  late final List<DateTime> hours = _hours();

  TimeSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    var day = ref.watch(dayProvider);
    var activityData = ref.watch(dayActivityProvider);
    return Column(
      children: [
        _header(),
        Expanded(
            child: activityData.when(
                data: (data) {
                  return ScrollablePositionedList.separated(
                      initialScrollIndex: initialIndex,
                      itemCount: hours.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        // onTap: () => context.go('/new-time-entry'),
                        return Container(
                          color: index % 2 == 0
                              ? Colors.transparent
                              : colorScheme.background,
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Time
                                SizedBox(
                                    width: 75,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          DateFormat('hh:mm a')
                                              .format(hours[index]),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )),
                                // Planned
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: _getActivityCards(
                                      colorScheme,
                                      context,
                                      data.planned[index],
                                      index,
                                      TaskEntryType.planned),
                                )),
                                // Actual
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: _getActivityCards(
                                      colorScheme,
                                      context,
                                      data.actual[index],
                                      index,
                                      TaskEntryType.actual),
                                )),
                              ]),
                        );
                      });
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => const Text('Error'))),
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

  List<Widget> _getActivityCards(ColorScheme colorScheme, BuildContext context,
      List<Activity>? activities, int hour, TaskEntryType taskType) {
    List<Widget> list = [];

    if (activities?.isNotEmpty ?? false) {
      for (var activity in activities!) {
        list.add(
          Card(
            color: colorScheme.secondaryContainer,
            child: InkWell(
              onTap: () {
                context.go('/new-time-entry');
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(activity.title),
              ),
            ),
          ),
        );
      }
    }

    // Add "Add new" card
    list.add(
      Card(
        color: colorScheme.secondaryContainer,
        child: InkWell(
          onTap: () {
            context.go('/new-time-entry');
          },
          child: const Align(alignment: Alignment.center, child: Text('+')),
        ),
      ),
    );
    return list;
  }

  SizedBox _header() {
    return const SizedBox(
      height: 30,
      child: Row(children: [
        SizedBox(
            width: 75,
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Align(alignment: Alignment.center, child: Text('Time')),
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
