import 'package:flutter/material.dart';

typedef ItemBuiler<T> = Widget Function(T value);
typedef ItemGen<T> = T Function(T value);

class BasicSlider<T> extends StatefulWidget {
  const BasicSlider(
      {super.key,
      this.widgetHeight = 70,
      required this.firstState,
      required this.selectedItem,
      this.numOfItem = 5,
      required this.itemBuiler,
      required this.nextItem,
      required this.prevItem});

  final double widgetHeight;
  final T firstState;
  final T selectedItem;
  final int numOfItem;
  final ItemBuiler<T> itemBuiler;
  final ItemGen<T> nextItem;
  final ItemGen<T> prevItem;

  @override
  _BasicSliderState createState() => _BasicSliderState<T>();
}

class _BasicSliderState<T> extends State<BasicSlider<T>> {
  late List<Widget> items;
  late T currentStartItem;
  late T selectedItem;

  @override
  void initState() {
    super.initState();
    currentStartItem = widget.firstState;
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    items = _getItems();
    return SizedBox(
      height: widget.widgetHeight,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              T currentItem = currentStartItem;
              for (int i = 0; i < widget.numOfItem; i++) {
                currentItem = widget.prevItem(currentItem);
              }
              setState(() {
                currentStartItem = currentItem;
              });
            },
          ),
        ),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              for (var widget in items) widget,
            ])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              T currentItem = currentStartItem;
              for (int i = 0; i < widget.numOfItem; i++) {
                currentItem = widget.nextItem(currentItem);
              }
              setState(() {
                currentStartItem = currentItem;
              });
            },
          ),
        )
      ]),
    );
  }

  List<Widget> _getItems() {
    List<Widget> list = [];
    T currentItem = currentStartItem;

    for (int i = 0; i < widget.numOfItem; i++) {
      list.add(widget.itemBuiler(currentItem));
      currentItem = widget.nextItem(currentItem);
    }

    return list;
  }
}
