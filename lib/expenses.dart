import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: const Text('Expenses'),
      ),
      Expanded(
        child: ListView(children: [
          for (int index = 0; index < 20; index++)
            ListTile(title: Text('Tile $index')),
        ]),
      )
    ]);
  }
}
