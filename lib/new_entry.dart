import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/providers/expense_provider.dart';
import 'package:tracker/util.dart';

import 'providers/category_provider.dart';
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
    var subCatList = ref.watch(subCategoryProvider);
    var selectedSubCat = ref.watch(selectedSubCatProvider);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.push('/add-category');
                        },
                        child: const Text('Add/Edit category'))
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: categoryList.when(
                        data: (data) {
                          return DropdownButtonFormField(
                              value: currentCategory,
                              items: data
                                  .where(
                                      (element) => element.subCategory.isEmpty)
                                  .map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.category,
                                  child: Text(e.category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                ref.read(currentCatProvider.notifier).state =
                                    value!;
                              });
                        },
                        error: (error, stack) =>
                            const Text('Some error occured'),
                        loading: () => const CircularProgressIndicator())),
                Visibility(
                  visible: subCatList.isNotEmpty,
                  child: SizedBox(
                    height: 40,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ['None', ...subCatList].map(
                          (subCat) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ChoiceChip(
                                label: Text(
                                  subCat,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                onSelected: (isSelected) => ref
                                    .read(selectedSubCatProvider.notifier)
                                    .state = subCat,
                                selected: subCat == selectedSubCat,
                              ),
                            );
                          },
                        ).toList()),
                  ),
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
                              categoryType: categoryType,
                              category: currentCategory,
                              subCategory: selectedSubCat == 'None'
                                  ? ''
                                  : selectedSubCat));

                          if (entryId > 0 && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Entry added')));

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
