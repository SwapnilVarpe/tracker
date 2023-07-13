import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/providers/money_stat_provider.dart';
import 'package:tracker/util.dart';

import 'constants.dart';

class MoneyStats extends ConsumerWidget {
  const MoneyStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(moneyStateProvider);
    var categories = ref.read(moneyStateProvider.notifier).getCategories();
    var subCategories =
        ref.read(moneyStateProvider.notifier).getSubCategories();
    var entries = ref.read(moneyStateProvider.notifier).getEntries();
    double total = entries.isEmpty
        ? 0
        : entries
            .map((e) => e.amount)
            .reduce((value, element) => value + element);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
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
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                          onSelected: (isSelected) {
                            ref.read(moneyStateProvider.notifier).month = month;
                          },
                          selected: state.month == month
                          // backgroundColor: colorScheme.secondaryContainer,
                          // selectedColor: colorScheme.primaryContainer,
                          ),
                    );
                  },
                ).toList()),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton(
              segments: <ButtonSegment<CategoryType>>[
                ButtonSegment(
                    value: CategoryType.expense,
                    label: Text(CategoryType.expense.asString())),
                ButtonSegment(
                    value: CategoryType.income,
                    label: Text(CategoryType.income.asString())),
                ButtonSegment(
                    value: CategoryType.investment,
                    label: Text(CategoryType.investment.asString())),
              ],
              selected: <CategoryType>{state.categoryType},
              onSelectionChanged: (Set<CategoryType> selected) {
                ref.read(moneyStateProvider.notifier).categoryType =
                    selected.first;
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Category:'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['', ...categories]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(e.isEmpty ? 'All' : e),
                          selected: e == state.category,
                          onSelected: (value) => ref
                              .read(moneyStateProvider.notifier)
                              .category = e,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Sub category:'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['', ...subCategories]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(e.isEmpty ? 'All' : e),
                          selected: e == state.subCategory,
                          onSelected: (value) => ref
                              .read(moneyStateProvider.notifier)
                              .subCategory = e,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '₹${formatNum(total)}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getAmountColor(state.categoryType),
                  fontSize: 18),
            ),
          ),
        ),
        Expanded(
            child: ListView(
                children: entries
                    .map((e) => Card(
                            child: ListTile(
                          trailing: Text(
                            '₹${formatNum(e.amount)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          title: Text(e.title),
                          subtitle: Text('${e.category} ${e.subCategory}'),
                        )))
                    .toList()))
      ],
    );
  }
}
