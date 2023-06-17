import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
              height: 100,
              child: Card(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('Investment'), Text('5000')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text('Expenses'), Text('23000')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('Income'), Text('10000')],
                        ),
                      )
                    ]),
              ))),
      Expanded(
        child: ListView(children: [
          for (int index = 0; index < 20; index++)
            ListTile(title: Text('Tile $index')),
        ]),
      )
    ]);
  }
}
