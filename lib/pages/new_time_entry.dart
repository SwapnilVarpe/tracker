import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewTimeEntry extends ConsumerWidget {
  final int? hour;
  const NewTimeEntry({super.key, this.hour});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New time entry'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Note'),
              ),
              const Text('Category'),
              SizedBox(
                height: 40,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['None'].map((e) {
                      return ChoiceChip(label: Text(e), selected: false);
                    }).toList()),
              ),
              const Text('Sub category'),
              SizedBox(
                height: 40,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['None'].map((e) {
                      return ChoiceChip(label: Text(e), selected: false);
                    }).toList()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Is this future event/reminder?'),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('All day'),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              ),
              const Text('Select time range'),
              RangeSlider(
                max: 60,
                min: 0,
                values: const RangeValues(0, 40),
                onChanged: (value) {},
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
