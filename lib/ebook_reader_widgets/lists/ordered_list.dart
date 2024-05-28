import 'package:flutter/material.dart';

class OrderedListWidget extends StatelessWidget {
  final List<String> items;
  final Color textColor;
  final double fontSize;

  const OrderedListWidget({
    Key? key,
    required this.items,
    this.textColor = Colors.white,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${index + 1}.'),
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
