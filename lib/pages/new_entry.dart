import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/providers/expense_provider.dart';
import 'package:tracker/providers/money_stat_provider.dart';
import 'package:tracker/util.dart';
import '../providers/category_provider.dart';
import '../constants.dart';

class NewEntry extends ConsumerStatefulWidget {
  final String? entryId;
  const NewEntry({super.key, this.entryId});

  @override
  ConsumerState<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends ConsumerState<NewEntry> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var categoryProvider = categoryStateProvider((id: widget.entryId ?? '', isActivity: false));
    var categoryState = ref.watch(categoryProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Add Entry')),
        body: categoryState.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : body(context, categoryState, categoryProvider));
  }

  Form body(BuildContext context, CategoryState categoryState,
      StateNotifierProvider<CategoryNotifier, CategoryState> categoryProvider) {
    var categoryType = categoryState.categoryType;
    var selectedCategory = categoryState.selectedCategory;
    var selectedSubCat = categoryState.selectedSubCat;
    var categoryList = categoryState.categoryList();
    var subCatList = categoryState.subCategoryList();
    var controllers = categoryState.controllers;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: controllers.amount,
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
            ),
            TextFormField(
              controller: controllers.title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
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
                          .read(categoryProvider.notifier)
                          .categoryType = CategoryType.expense),
                  FilterChip(
                      label: Text(CategoryType.income.asString()),
                      selected: categoryType == CategoryType.income,
                      showCheckmark: false,
                      onSelected: (onSelected) => ref
                          .read(categoryProvider.notifier)
                          .categoryType = CategoryType.income),
                  FilterChip(
                      label: Text(CategoryType.investment.asString()),
                      showCheckmark: false,
                      selected: categoryType == CategoryType.investment,
                      onSelected: (onSelected) => ref
                          .read(categoryProvider.notifier)
                          .categoryType = CategoryType.investment),
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
                child: DropdownButtonFormField(
                    value: selectedCategory,
                    items: categoryList.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.category,
                        child: Text(e.category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      ref.read(categoryProvider.notifier).selectedCategory =
                          value!;
                    })),
            Visibility(
              visible: subCatList.isNotEmpty,
              child: SizedBox(
                height: 40,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['None', ...subCatList].map(
                      (subCat) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ChoiceChip(
                            label: Text(
                              subCat,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
                            ),
                            onSelected: (isSelected) => ref
                                .read(categoryProvider.notifier)
                                .selectedSubCat = subCat,
                            selected: subCat == selectedSubCat,
                          ),
                        );
                      },
                    ).toList()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: controllers.date,
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

                    controllers.date.text = formattedDate;
                  }
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var entry = Entry(
                          id: widget.entryId != null
                              ? int.tryParse(widget.entryId ?? '')
                              : null,
                          title: controllers.title.text,
                          datetime: controllers.date.text,
                          amount: double.parse(controllers.amount.text),
                          categoryType: categoryType,
                          category: selectedCategory,
                          subCategory:
                              selectedSubCat == 'None' ? '' : selectedSubCat);
                      int entryId = entry.id != null
                          ? await DBHelper.updateEntry(entry)
                          : await DBHelper.insertEntry(entry);

                      if (entryId > 0 && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Entry added')));
                        controllers.title.text = '';
                        controllers.date.text = '';
                        controllers.amount.text = '';
                        ref.invalidate(entryListProvider);
                        ref.invalidate(moneyStateProvider);
                        ref.invalidate(categoryStateProvider);
                        context.go('/');
                      }
                    }
                  },
                  child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
