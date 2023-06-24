import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/providers/expense_provider.dart';
import 'package:tracker/util.dart';

import 'providers/new_entry_provider.dart';
import 'constants.dart';

class NewEntry extends ConsumerStatefulWidget {
  const NewEntry({super.key});

  @override
  ConsumerState<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends ConsumerState<NewEntry> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryType = ref.watch(catTypeProvider);
    var categoryList = ref.watch(categoryProvider);
    var currentCategory = ref.watch(currentCatProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Add Entry')),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Title cannot be empty'
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterChip(
                          label: Text(CategoryType.expense.asString()),
                          selected: categoryType == CategoryType.expense,
                          showCheckmark: false,
                          onSelected: (onSelected) => ref
                              .read(catTypeProvider.notifier)
                              .state = CategoryType.expense),
                      FilterChip(
                          label: Text(CategoryType.income.asString()),
                          selected: categoryType == CategoryType.income,
                          showCheckmark: false,
                          onSelected: (onSelected) => ref
                              .read(catTypeProvider.notifier)
                              .state = CategoryType.income),
                      FilterChip(
                          label: Text(CategoryType.investment.asString()),
                          showCheckmark: false,
                          selected: categoryType == CategoryType.investment,
                          onSelected: (onSelected) => ref
                              .read(catTypeProvider.notifier)
                              .state = CategoryType.investment),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField(
                      value: currentCategory,
                      items: categoryList.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        ref.read(currentCatProvider.notifier).state = value!;
                      }),
                ),
                TextFormField(
                  controller: amountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter an amount';
                    } else if (!isNumeric(value)) {
                      return 'Enter number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_month),
                      label: Text('Enter date')),
                  readOnly: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter a date' : null,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050));

                    if (date != null) {
                      var formattedDate = DateFormat('yyyy-MM-dd').format(date);

                      dateController.text = formattedDate;
                    }
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int entryId = await DBHelper.insertEntry(Entry(
                              title: titleController.text,
                              datetime: dateController.text,
                              amount: double.parse(amountController.text),
                              categoryType: categoryType.asString(),
                              category: currentCategory));

                          if (entryId > 0) {
                            // FIXME: usa of context in async.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: const Text('Entry added')));

                            ref.invalidate(entryListProvider);
                            context.go('/');
                          }
                        }
                      },
                      child: const Text("Submit")),
                )
              ],
            ),
          ),
        ));
  }
}
