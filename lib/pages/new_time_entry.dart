import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewTimeEntry extends ConsumerWidget {
  final int? hour;
  const NewTimeEntry({super.key, this.hour});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New time entry'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
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
                padding: const EdgeInsets.only(top: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Category'),
                    SizedBox(
                      height: 40,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: ['None'].map((e) {
                            return ChoiceChip(label: Text(e), selected: false);
                          }).toList()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sub category'),
                    SizedBox(
                      height: 40,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: ['None'].map((e) {
                            return ChoiceChip(label: Text(e), selected: false);
                          }).toList()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Duration (max 60 min)'),
                    Slider(
                        max: 60,
                        divisions: 60,
                        value: 50,
                        onChanged: (value) {})
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Difficulty (max 10)'),
                    Slider(
                        max: 10, divisions: 10, value: 5, onChanged: (value) {})
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Satisfaction (max 10)'),
                    Slider(
                        max: 10, divisions: 10, value: 5, onChanged: (value) {})
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Self/Group (Is group)'),
                    Switch(value: false, onChanged: (value) {})
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    ElevatedButton(onPressed: () {}, child: const Text('Save')),
              )
            ],
          ),
        ));
  }
}
