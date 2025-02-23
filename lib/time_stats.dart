import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracker/providers/modal/time_stat.dart';
import 'package:tracker/providers/time_stats_provider.dart';

class TimeStats extends ConsumerWidget {
  const TimeStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dateRange = ref.watch(dateRangeProvider);
    var statsType = ref.watch(statTypeProvider);
    var stats = ref.watch(statsProvider);

    var dateRangeDiff = dateRange.duration.inDays;

    return stats.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('Error'),
      data: (statsData) {
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
                      '${DateFormat('dd MMM yy').format(dateRange.start)}  -  ${DateFormat('dd MMM yy').format(dateRange.end)}'),
              readOnly: true,
              textAlign: TextAlign.center,
              onTap: () async {
                DateTimeRange? dateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000));

                if (dateRange != null) {
                  ref.read(dateRangeProvider.notifier).state = dateRange;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<StatsType>(
                value: statsType,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: StatsType.timeSpent,
                    child: Text('Time spent'),
                  ),
                  DropdownMenuItem(
                    value: StatsType.plannedVsActual,
                    child: Text('Planned Vs Actual'),
                  ),
                  // DropdownMenuItem(
                  //   value: StatsType.satisfaction,
                  //   child: Text('Satisfaction'),
                  // )
                ],
                onChanged: (StatsType? value) {
                  if (value != null) {
                    ref.read(statTypeProvider.notifier).state = value;
                  }
                },
              ),
            ),
            if (statsData.isNotEmpty) totalActivity(statsData, dateRangeDiff),
            Expanded(
                child: statsData.isEmpty
                    ? const Center(child: Text('No Data'))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          var item = statsData[index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item.category,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            if (dateRangeDiff > 0)
                                              Text(
                                                ' (${(item.duration / dateRangeDiff).floor()} min / day)',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                          ],
                                        ),
                                        Text(
                                          formatDuration(item.duration),
                                          style: const TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    for (var subCat in item.subCategory)
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('-  ${subCat.category}'),
                                            Text(formatDuration(
                                                subCat.duration)),
                                          ]),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: statsData.length,
                      ))
          ],
        );
      },
    );
  }

  Padding totalActivity(List<TimeStat> statsData, int dateRangeDiff) {
    var total =
        statsData.fold<double>(0, (value, element) => value + element.duration);
    var perDay = '';
    if (dateRangeDiff > 0) {
      total = total / dateRangeDiff;
      perDay = ' per day';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Total Activities: ${formatDuration(total)} $perDay',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  String formatDuration(double minutes) {
    var dur = Duration(minutes: minutes.toInt());
    return prettyDuration(dur,
        abbreviated: true,
        tersity: DurationTersity.minute,
        upperTersity: DurationTersity.day);
  }
}
