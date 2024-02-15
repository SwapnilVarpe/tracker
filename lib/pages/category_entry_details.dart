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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: entries.when(
                data: (data) {
                  var total = data.$2;
                  var list = data.$1;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var item = list[index];

                      if (item.isHeader) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 24, bottom: 8),
                          child: Text(
                            item.header,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        );
                      }
                      var entry = item.entry;
                      if (entry == null) return const Text("");

                      var title = item.isGroupby
                          ? entry.subCategory
                          : (entry.title.isEmpty
                              ? '${item.entry?.category} ${item.entry?.subCategory}'
                              : entry.title);
                      var amount = item.entry?.amount ?? 0;

                      return Card(
                        child: ListTile(
                            title: Text(title.isEmpty ? '-' : title),
                            trailing: Text(
                              '₹${formatNum(amount)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: item.isGroupby
                                ? Text(
                                    '${formatDecimal2D(amount * 100 / total)}%')
                                : Text(formatDateDdMmm(entry.datetime))),
                      );
                    },
                  );
                },
                error: (error, stackTrace) => const Text('Error'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
