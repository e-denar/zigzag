import 'package:flutter/material.dart';

class ChangeViewWidget extends StatelessWidget {
  final color;
  final icon;
  final title;
  final value;

  const ChangeViewWidget({
    Key key,
    this.value,
    this.color,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            Text(
              isDecimal()
                  ? '${value.toStringAsFixed(2)}%'
                  : '${value.toStringAsFixed(1)}%',
              style: TextStyle(
                  color: color, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(title, style: TextStyle(color: color, fontSize: 12.5)),
          ],
        ),
      ),
    );
  }

  isDecimal() => value < 10;
}
