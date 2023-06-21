import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Nov',
  'Dec'
];

final monthProvider = StateProvider<String>((ref) {
  return months[0];
});

class Expenses extends ConsumerWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var selectedMonth = ref.watch(monthProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SizedBox(
              height: 100,
              child: Card(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('Investment'), Text('5000')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text('Expenses'), Text('23000')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('Income'), Text('10000')],
                        ),
                      )
                    ]),
              ))),
      SizedBox(
        height: 40,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: months.map(
              (month) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: FilterChip(
                    label: Text(
                      month,
                      style: TextStyle(color: colorScheme.onSecondaryContainer),
                    ),
                    onSelected: (isSelected) =>
                        ref.read(monthProvider.notifier).state = month,
                    selected: selectedMonth == month,
                    // backgroundColor: colorScheme.secondaryContainer,
                    // selectedColor: colorScheme.primaryContainer,
                  ),
                );
              },
            ).toList()),
      ),
      Expanded(
        child: ListView(children: [
          for (int index = 0; index < 20; index++)
            ListTile(title: Text('Tile $index')),
        ]),
      )
    ]);
  }
}
