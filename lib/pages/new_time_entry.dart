import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/activity.dart';
import 'package:tracker/providers/category_provider.dart';
import 'package:tracker/providers/time_schedule_provider.dart';
import 'package:uuid/uuid.dart';

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
  var categoryProvider = categoryStateProvider((id: '', isActivity: true));
  final titleController = TextEditingController();
  final uuid = const Uuid();
  double _duration = 15.0;
  double _difficulty = 0.0;
  double _satisfaction = 0.0;
  late DateTime _currentHour;
  bool _isGroup = false;
  Activity? currentActivity;

  @override
  void initState() {
    super.initState();
    _currentHour = widget.hour;
    getActivity();
  }

  Future<void> getActivity() async {
    if (widget.activityId != null && widget.activityId! > 0) {
      var act = await DBHelper.getActivityById(widget.activityId!.toString());

      if (act != null) {
        currentActivity = act;
        titleController.text = act.title;
        ref.read(categoryProvider.notifier).selectedCategory = act.category;
        ref.read(categoryProvider.notifier).selectedSubCat = act.subCategory;
        _duration = act.duration;
        _difficulty = act.difficulty;
        _satisfaction = act.satisfaction;
        _currentHour = act.activityDate;
        _isGroup = act.isGroupActivity == 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var categoryState = ref.watch(categoryProvider);

    var selectedCategory = categoryState.selectedCategory;
    var selectedSubCat = categoryState.selectedSubCat;
    var categoryList = categoryState.categoryList();
    var subCatList = categoryState.subCategoryList();
    var hourList = ref.read(hourProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('New time entry'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter title' : null,
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
                              ref
                                  .read(categoryProvider.notifier)
                                  .selectedCategory = value!;
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Hour'),
                                DropdownButtonFormField(
                                    value: _currentHour,
                                    items: hourList.map((e) {
                                      return DropdownMenuItem<DateTime>(
                                        value: e,
                                        child: Text(
                                            DateFormat('hh:mm a').format(e)),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _currentHour = value!;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              deleteButton(context),
              Visibility(
                  visible: widget.activityId != null &&
                      widget.taskEntryType == TaskEntryType.planned,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        var activity = Activity(
                            title: titleController.text,
                            category: selectedCategory,
                            subCategory:
                                selectedSubCat == 'None' ? '' : selectedSubCat,
                            activityDate: _currentHour,
                            taskEntryType: TaskEntryType.actual,
                            isGroupActivity: _isGroup ? 1 : 0,
                            uuid: uuid.v4(),
                            copyUuid: currentActivity?.uuid,
                            duration: _duration,
                            difficulty: _difficulty,
                            satisfaction: _satisfaction);

                        int id = await DBHelper.insertActivity(activity);

                        if (id > 0 && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Activity copied to actual')));

                          ref.invalidate(categoryProvider);
                          ref.invalidate(dayActivityProvider);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Mark as done'),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      var activity = Activity(
                          id: widget.activityId,
                          uuid: currentActivity == null
                              ? uuid.v4()
                              : currentActivity!.uuid,
                          title: titleController.text,
                          category: selectedCategory,
                          subCategory:
                              selectedSubCat == 'None' ? '' : selectedSubCat,
                          activityDate: _currentHour,
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
                            const SnackBar(content: Text('Activity added')));

                        ref.invalidate(categoryProvider);
                        ref.invalidate(dayActivityProvider);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save')),
              )
            ],
          ),
        ));
  }

  Visibility deleteButton(BuildContext context) {
    return Visibility(
        visible: widget.activityId != null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (context2) => AlertDialog(
                  content: const Text('Do you want to delete this activity.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context2),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () async {
                          if (widget.activityId != null) {
                            int num = await DBHelper.deleteActivity(
                                widget.activityId ?? 0);
                            if (context2.mounted) {
                              if (num > 0) {
                                ScaffoldMessenger.of(context2).showSnackBar(
                                    const SnackBar(
                                        content: Text('Activity deleted')));
                                ref.invalidate(dayActivityProvider);
                                Navigator.pop(context2);
                                Navigator.pop(context);
                              }
                            }
                          }
                        },
                        child: const Text('Delete'))
                  ],
                ),
              );
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
