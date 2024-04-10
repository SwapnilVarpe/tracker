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
                value: StatsType.TimeSpent,
                child: Text('Time spent'),
              ),
              DropdownMenuItem(
                value: StatsType.PlannedVsActual,
                child: Text('Planned Vs Actual'),
              ),
              DropdownMenuItem(
                value: StatsType.Satisfaction,
                child: Text('Satisfaction'),
              )
            ],
            onChanged: (StatsType? value) {
              if (value != null) {
                ref.read(statTypeProvider.notifier).state = value;
              }
            },
          ),
        ),
        Expanded(
            child: stats.when(
          data: (data) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var item = data[index];
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.category),
                      Text('${item.duration} min')
                    ],
                  ),
                );
              },
              itemCount: data.length,
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text('Error'),
        ))
      ],
    );
  }
}
