import 'package:flutter/material.dart';
import 'package:zigzag/app/pages/home/country_highlight.dart';
import 'package:zigzag/app/widgets/master.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              CountryHighlight(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Master(),
              )
            ],
          )),
    );
  }
}
