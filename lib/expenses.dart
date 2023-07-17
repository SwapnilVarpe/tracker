import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:tracker/db/db_helper.dart';
import 'package:tracker/util.dart';
import 'providers/expense_provider.dart';
import 'constants.dart';
import 'modal/entry.dart';

class Expenses extends ConsumerWidget {
  final ItemScrollController scrollController = ItemScrollController();
  Expenses({super.key}) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (scrollController.isAttached) {
          var curMonth = DateTime.now().month;
          scrollController.scrollTo(
              index: curMonth - 3,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    var selectedMonth = ref.watch(monthProvider);
    AsyncValue<List<Entry>> entryList = ref.watch(entryListProvider);
    var summary = ref.watch(summaryProvider).value;

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      summaryCard(colorScheme, summary),
      SizedBox(
        height: 40,
        child: ScrollablePositionedList.builder(
            itemScrollController: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: months.length,
            itemBuilder: (context, index) {
              var month = months[index];
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
                ),
              );
            }),
      ),
      Expanded(
        child: entryList.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var entry = data[index];
                    return Card(
                        child: ListTile(
                      leading: Icon(
                        getAmountIcon(entry.categoryType),
                        color: getAmountColor(entry.categoryType),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '₹${formatNum(entry.amount)}',
                            style: TextStyle(
                                color: getAmountColor(entry.categoryType),
                                fontSize: 17),
                          ),
                          const SizedBox(width: 10),
                          cardMenuButton(entry, ref)
                        ],
                      ),
                      title: Text(entry.title),
                      subtitle: Text(
                          '${formatDateDdMmm(entry.datetime)} : ${entry.category} ${entry.subCategory}'),
                    ));
                  },
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => const Text('Error')),
      )
    ]);
  }

  Padding summaryCard(ColorScheme colorScheme, Map<String, double>? summary) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SizedBox(
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
                      '₹${summary != null ? formatNum(summary[CategoryType.expense.asString()] ?? 0) : 0}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                        '₹${summary != null ? formatNum(summary[CategoryType.income.asString()] ?? 0) : 0}',
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
                        '₹${summary != null ? formatNum(summary[CategoryType.investment.asString()] ?? 0) : 0}',
                      )
                    ],
                  ),
                )
              ]),
            ],
          ),
        )));
  }

  PopupMenuButton<dynamic> cardMenuButton(Entry entry, WidgetRef ref) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text('Edit'),
          onTap: () => context.go(Uri(
              path: '/addEntry',
              queryParameters: {'entryId': entry.id.toString()}).toString()),
        ),
        PopupMenuItem(
          child: const Text('Delete'),
          onTap: () {
            Future.delayed(
                Duration.zero,
                () => showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        content:
                            const Text('Do you want to delete this entry.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                if (entry.id != null) {
                                  int num =
                                      await DBHelper.deleteEntry(entry.id ?? 0);
                                  if (context.mounted) {
                                    if (num > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text('Entry deleted')));
                                      ref.invalidate(entryListProvider);
                                      Navigator.pop(context);
                                    }
                                  }
                                }
                              },
                              child: const Text('Delete'))
                        ],
                      ),
                    ));
          },
        )
      ],
    );
  }
}
