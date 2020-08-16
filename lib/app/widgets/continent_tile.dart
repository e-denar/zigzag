import 'package:flutter/material.dart';
import 'package:zigzag/domain/entities/continent.dart';

import 'change_summary.dart';

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
            ChangeSummary(
              cases: continent.casesIncreasedBy,
              deaths: continent.deathsIncreasedBy,
              recoveries: continent.recoveriesIncreasedBy,
            )
          ],
        ),
      ),
    );
  }
}
