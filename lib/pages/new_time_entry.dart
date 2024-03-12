import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/activity.dart';
import 'package:tracker/providers/category_provider.dart';
import 'package:tracker/providers/time_schedule_provider.dart';

class NewTimeEntry extends ConsumerStatefulWidget {
  final DateTime hour;
  final TaskEntryType taskEntryType;
  final int? activityId;

  const NewTimeEntry(
      {super.key,
      this.activityId,
      required this.hour,
      required this.taskEntryType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewTimeEntryState();
}

class _NewTimeEntryState extends ConsumerState<NewTimeEntry> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  double _duration = 15.0;
  double _difficulty = 3.0;
  double _satisfaction = 3.0;
  bool _isGroup = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = categoryStateProvider((id: '', isActivity: true));
    var categoryState = ref.watch(categoryProvider);

    var selectedCategory = categoryState.selectedCategory;
    var selectedSubCat = categoryState.selectedSubCat;
    var categoryList = categoryState.categoryList();
    var subCatList = categoryState.subCategoryList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('New time entry'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (value) => value!.isEmpty ? 'Enter title' : null,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.push(Uri(
                                  path: '/add-category',
                                  queryParameters: {'isActivity': 'true'})
                              .toString());
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
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Duration ($_duration min)'),
                      Slider(
                          max: 60,
                          divisions: 60,
                          value: _duration,
                          label: _duration.toString(),
                          onChanged: (value) => setState(() {
                                _duration = value;
                              }))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Difficulty ($_difficulty)'),
                      Slider(
                          max: 10,
                          divisions: 10,
                          value: _difficulty,
                          label: _difficulty.toString(),
                          onChanged: (value) {
                            setState(() {
                              _difficulty = value;
                            });
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Satisfaction ($_satisfaction)'),
                      Slider(
                          max: 10,
                          divisions: 10,
                          value: _satisfaction,
                          label: _satisfaction.toString(),
                          onChanged: (value) {
                            setState(() {
                              _satisfaction = value;
                            });
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Self/Group (Is group)'),
                      Switch(
                          value: _isGroup,
                          onChanged: (value) {
                            setState(() {
                              _isGroup = value;
                            });
                          })
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var activity = Activity(
                              id: widget.activityId,
                              title: titleController.text,
                              category: selectedCategory,
                              subCategory: selectedSubCat == 'None'
                                  ? ''
                                  : selectedSubCat,
                              activityDate: widget.hour,
                              taskEntryType: widget.taskEntryType,
                              isGroupActivity: _isGroup ? 1 : 0,
                              duration: _duration,
                              difficulty: _difficulty,
                              satisfaction: _satisfaction);

                          int id = activity.id != null
                              ? await DBHelper.updateActivity(activity)
                              : await DBHelper.insertActivity(activity);

                          if (id > 0 && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Activity added')));

                            ref.invalidate(dayActivityProvider);
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: const Text('Save')),
                )
              ],
            ),
          ),
        ));
  }
}
