import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/expense_provider.dart';
import 'constants.dart';
import 'modal/entry.dart';

class Expenses extends ConsumerWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    var selectedMonth = ref.watch(monthProvider);
    AsyncValue<List<Entry>> entryList = ref.watch(entryListProvider);
    var summary = ref.watch(summaryProvider).value;

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SizedBox(
              // height: 100,
              child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Expenses',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface),
                      ),
                      Text(
                        '₹${summary != null ? summary[CategoryType.expense.asString()] ?? 0 : 0}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface)),
                            Text(
                              '₹${summary != null ? summary[CategoryType.income.asString()] ?? 0 : 0}',
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Investment',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface)),
                            Text(
                              '₹${summary != null ? summary[CategoryType.investment.asString()] ?? 0 : 0}',
                            )
                          ],
                        ),
                      )
                    ]),
              ],
            ),
          ))),
      SizedBox(
        height: 40,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: months.map(
              (month) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
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
        child: entryList.when(
            data: (data) {
              return ListView(
                  children: data.map((entry) {
                return Card(
                    child: ListTile(
                  leading: Icon(
                    getAmountIcon(entry),
                    color: getAmountColor(entry),
                  ),
                  trailing: Text(
                    '₹${entry.amount}',
                    style:
                        TextStyle(color: getAmountColor(entry), fontSize: 17),
                  ),
                  title: Text(entry.title),
                  subtitle: Text(entry.categoryType.asString()),
                ));
              }).toList());
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => const Text('Error')),
      )
    ]);
  }

  Color getAmountColor(Entry entry) {
    switch (entry.categoryType) {
      case CategoryType.expense:
        return Colors.red;
      case CategoryType.income:
        return Colors.green;
      case CategoryType.investment:
        return Colors.orange;
    }
  }

  IconData getAmountIcon(Entry entry) {
    switch (entry.categoryType) {
      case CategoryType.expense:
        return Icons.payments;
      case CategoryType.income:
        return Icons.attach_money;
      case CategoryType.investment:
        return Icons.trending_up;
    }
  }
}
