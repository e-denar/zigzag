import 'package:flutter/material.dart';
import 'package:zigzag/domain/entities/continent.dart';

import 'change_view_widget.dart';

class ContinentTile extends StatelessWidget {
  final Continent continent;
  final onTap;
  const ContinentTile({Key key, this.continent, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  continent.name,
                  style: TextStyle(fontSize: 22),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: onTap,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChangeViewWidget(
                  value: continent.casesIncreasedBy,
                  title: 'Cases',
                  icon: Icons.add_circle,
                  color: Color.fromRGBO(255, 165, 0, 1),
                ),
                ChangeViewWidget(
                  value: continent.casesIncreasedBy,
                  title: 'Recoveries',
                  icon: Icons.favorite,
                  color: Color.fromRGBO(102, 255, 0, 1),
                ),
                ChangeViewWidget(
                  value: continent.deathsIncreasedBy,
                  title: 'Deaths',
                  icon: Icons.remove_circle,
                  color: Color.fromRGBO(255, 27, 7, 1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
