import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zigzag/app/widgets/details.dart';
import 'package:zigzag/domain/blocs/continent_bloc.dart';
import 'package:zigzag/domain/entities/continent.dart';

import 'continent_tile.dart';
import 'left_page_route.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  Stream<List<Continent>> _stream;

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<ContinentBloc>(context, listen: false);
    _stream = bloc.continents;
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height * 0.7;
    return Container(
      height: _height,
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Continents',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Continent>>(
              initialData: [],
              stream: _stream,
              builder: (context, continents) {
                if (continents.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: continents.data.length,
                      itemBuilder: (context, index) {
                        final _continent = continents.data.elementAt(index);
                        return ContinentTile(
                            continent: _continent,
                            onTap: () {
                              Navigator.push(
                                context,
                                LeftPageRoute(
                                  widget: Details(
                                      continents: continents.data,
                                      selected: index,
                                      offset:
                                          MediaQuery.of(context).size.height *
                                              0.6 *
                                              index),
                                ),
                              );
                            });
                      });
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
