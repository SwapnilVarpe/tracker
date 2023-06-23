import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/new_entry_provider.dart';
import 'constants.dart';

class NewEntry extends ConsumerStatefulWidget {
  const NewEntry({super.key});

  @override
  ConsumerState<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends ConsumerState<NewEntry> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var categoryType = ref.watch(catTypeProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Add Entry')),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.expense,
                          groupValue: categoryType,
                          onChanged: (type) => ref
                              .read(catTypeProvider.notifier)
                              .state = CategoryType.expense),
                      Text(CategoryType.expense.asString())
                    ],
                  ),
                  Radio(
                      value: CategoryType.income,
                      groupValue: categoryType,
                      onChanged: (type) => ref
                          .read(catTypeProvider.notifier)
                          .state = CategoryType.income),
                  Radio(
                      value: CategoryType.investment,
                      groupValue: categoryType,
                      onChanged: (type) => ref
                          .read(catTypeProvider.notifier)
                          .state = CategoryType.investment),
                ],
              ),
              TextFormField(),
              ElevatedButton(onPressed: () {}, child: Text("Submit"))
            ],
          ),
        ));
  }
}
