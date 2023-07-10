import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/providers/money_stat_provider.dart';

import 'constants.dart';

class MoneyStats extends ConsumerWidget {
  const MoneyStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(moneyStateProvider);
    return Column(
      children: [
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
        SegmentedButton(
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
            ref.read(moneyStateProvider.notifier).categoryType = selected.first;
          },
        )
      ],
    );
  }
}
