import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracker/providers/modal/money_stat.dart';
import 'package:tracker/providers/money_stat_provider.dart';
import 'package:tracker/util.dart';

import 'constants.dart';

class MoneyStats extends ConsumerWidget {
  const MoneyStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(moneyStateProvider);
    double total = state.entries.isEmpty
        ? 0
        : state.entries
            .map((e) => e.amount)
            .reduce((value, element) => value + element);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            children: [
              const Text('Filter by:'),
              Radio(
                  value: FilterBy.month,
                  groupValue: state.filterBy,
                  onChanged: (filter) => ref
                      .read(moneyStateProvider.notifier)
                      .filterBy = FilterBy.month),
              const Text('Month'),
              const SizedBox(
                width: 16,
              ),
              Radio(
                  value: FilterBy.dateRage,
                  groupValue: state.filterBy,
                  onChanged: (filter) => ref
                      .read(moneyStateProvider.notifier)
                      .filterBy = FilterBy.dateRage),
              const Text('Date range')
            ],
          ),
        ),
        Visibility(
          visible: state.filterBy == FilterBy.month,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 40,
              child: ScrollablePositionedList.builder(
                  initialScrollIndex: state.initialScrollIndex,
                  scrollDirection: Axis.horizontal,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    var month = months[index];
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
                          selected: state.month == month),
                    );
                  }),
            ),
          ),
        ),
        Visibility(
            visible: state.filterBy == FilterBy.dateRage,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: state.startDate),
                      readOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(state.startDate),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));

                        if (date != null) {
                          var formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          ref.read(moneyStateProvider.notifier).startDate =
                              formattedDate;
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(text: state.endDate),
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(state.endDate),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));

                        if (date != null) {
                          var formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          ref.read(moneyStateProvider.notifier).endDate =
                              formattedDate;
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
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
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              children: state.entries
                  .map((e) => Card(
                          child: ListTile(
                        trailing: Text(
                          '₹${formatNum(e.amount)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        title: Text(e.category),
                        subtitle:
                            Text('${formatDecimal2D(e.amount * 100 / total)}%'),
                        onTap: () => context.push(Uri(
                            path: '/category-entry-details',
                            queryParameters: {
                              'category': e.category,
                              'startDate': state.startDate,
                              'endDate': state.endDate,
                              'categoryType': state.categoryType.asString()
                            }).toString()),
                      )))
                  .toList()),
        ))
      ],
    );
  }
}
