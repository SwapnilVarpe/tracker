import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/expense_provider.dart';
import 'constants.dart';
import 'modal/entry.dart';

class Expenses extends ConsumerWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var selectedMonth = ref.watch(monthProvider);
    AsyncValue<List<Entry>> entryList = ref.watch(entryListProvider);

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
                  leading: const Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                  trailing: Text(
                    '₹ ${entry.amount}',
                    style: const TextStyle(color: Colors.green, fontSize: 17),
                  ),
                  title: Text(entry.title),
                  subtitle: Text(entry.categoryType),
                ));
              }).toList());
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => const Text('Error')),
      )
    ]);
  }
}
