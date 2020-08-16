import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:zigzag/app/widgets/change_summary.dart';
import 'package:zigzag/domain/blocs/country_bloc.dart';
import 'package:zigzag/domain/blocs/theme_bloc.dart';
import 'package:zigzag/domain/entities/continent.dart';
import 'package:zigzag/domain/entities/country.dart';
import 'package:zigzag/domain/blocs/selected_country_bloc.dart';

class Details extends StatefulWidget {
  const Details({this.continents, this.selected, this.offset});
  final List<Continent> continents;
  final int selected;
  final offset;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<Continent> _continents;
  Stream<Map<String, Country>> _stream;
  SelectedCountryBloc selectionBloc;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<CountryBloc>(context, listen: false);
    bloc.fetchCountries();
    _stream = bloc.countries;
    _continents = widget.continents;
    _scrollController = ScrollController(initialScrollOffset: widget.offset);
    selectionBloc = Provider.of<SelectedCountryBloc>(context, listen: false);
  }

  void _changeTheme(String countryName) {
    final themeBloc = Provider.of<ThemeBloc>(context, listen: false);
    themeBloc.randomBgColor();
    selectionBloc.selectCountry(countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
            padding: const EdgeInsets.only(top: 20),
            child: StreamBuilder<Map<String, Country>>(
              stream: _stream,
              builder: (context, country) {
                if (country.hasData) {
                  return Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: _continents.length,
                      itemBuilder: (context, continentIndex) => Column(
                        children: [
                          _buildHeader(context, continentIndex),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: _buildCountryList(continentIndex, country),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final bloc = Provider.of<CountryBloc>(context, listen: false);
                return FutureBuilder(
                  future: bloc.fetchCountries(),
                  builder: (_, __) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )));
  }

  ListView _buildCountryList(
      int continentIndex, AsyncSnapshot<Map<String, Country>> country) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _continents.elementAt(continentIndex).countries.length,
        itemBuilder: (context, index) {
          final countryName =
              _continents.elementAt(continentIndex).countries.elementAt(index);
          final _country = country.data[countryName];
          return _buildDraggableTile(TileIdentifier(
              continentIndex: continentIndex,
              countryIndex: index,
              country: _country));
        });
  }

  Widget _buildDraggableTile(TileIdentifier target) {
    final _widget = ExpansionTile(
      leading: IconButton(
        icon: selectionBloc.currentSelected == target.country.name
            ? Icon(
                Icons.star,
                color: Colors.yellow,
              )
            : Icon(Icons.star_border),
        onPressed: () => _changeTheme(target.country.name),
      ),
      title: Text(target.country.name),
      trailing: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 40, maxWidth: 60),
          child: Image.network(
            target.country.flag,
            scale: 6,
          )),
      children: [
        ChangeSummary(
          cases: target.country.casesIncreasedBy,
          recoveries: target.country.recoveriesIncreasedBy,
          deaths: target.country.deathsIncreasedBy,
        )
      ],
    );

    Draggable _tile = LongPressDraggable<TileIdentifier>(
      data: target,
      child: _widget,
      feedback: Material(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            target.country.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    return DragTarget<TileIdentifier>(
      onAccept: (toMove) {
        setState(() {
          final toInsert = _continents
              .elementAt(toMove.continentIndex)
              .countries
              .elementAt(toMove.countryIndex);
          _continents
              .elementAt(toMove.continentIndex)
              .countries
              .removeAt(toMove.countryIndex);
          _continents
              .elementAt(target.continentIndex)
              .countries
              .insert(target.countryIndex, toInsert);
        });
      },
      builder: (context, candidateData, rejectedData) => _tile,
    );
  }

  Padding _buildHeader(BuildContext context, int continentIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            _continents.elementAt(continentIndex).name,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class TileIdentifier {
  int continentIndex;
  int countryIndex;
  Country country;
  TileIdentifier({this.continentIndex, this.country, this.countryIndex});
}
