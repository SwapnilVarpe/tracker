import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:tracker/providers/category_entry_details_provider.dart';
import 'package:tracker/providers/modal/category_entry_detail.dart';
import 'package:tracker/util.dart';

class CategoryEntryDetails extends ConsumerWidget {
  final String startDate;
  final String endDate;
  final CategoryType categoryType;
  final String category;

  const CategoryEntryDetails(
      {super.key,
      required this.category,
      required this.categoryType,
      required this.endDate,
      required this.startDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(categoryEntryDetailsProvider(CategoryEntryDetail(
        start: startDate,
        end: endDate,
        categoryType: categoryType,
        category: category)));
    return Scaffold(
      appBar: AppBar(title: const Text('Category entry details')),
      body: Column(
        children: [
          const Text('Sub categories'),
          Expanded(
            child: entries.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var item = data[index];

                    if (item.isHeader) {
                      return Text(item.header);
                    }
                    var title = item.isGroupby
                        ? item.entry?.subCategory
                        : item.entry?.title;
                    var amount = item.entry?.amount;

                    return Card(
                      child: ListTile(
                        title: Text(title ?? ''),
                        trailing: Text(formatNum(amount ?? 0)),
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) => const Text('Error'),
              loading: () => const CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
