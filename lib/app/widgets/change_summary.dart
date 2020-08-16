import 'package:flutter/material.dart';

import 'change_view_widget.dart';

class ChangeSummary extends StatelessWidget {
  final cases, deaths, recoveries;

  const ChangeSummary({this.cases, this.deaths, this.recoveries});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ChangeViewWidget(
          value: cases,
          title: 'Cases',
          icon: Icons.add_circle,
          color: Color.fromRGBO(255, 165, 0, 1),
        ),
        ChangeViewWidget(
          value: recoveries,
          title: 'Recoveries',
          icon: Icons.favorite,
          color: Colors.green,
        ),
        ChangeViewWidget(
          value: deaths,
          title: 'Deaths',
          icon: Icons.remove_circle,
          color: Color.fromRGBO(255, 27, 7, 1),
        ),
      ],
    );
  }
}
