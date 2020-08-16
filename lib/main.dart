import 'package:flutter/material.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/blocs/continent_bloc.dart';
import 'package:zigzag/domain/blocs/country_bloc.dart';
import 'package:zigzag/domain/blocs/selected_country_bloc.dart';
import 'package:zigzag/domain/blocs/theme_bloc.dart';
import 'package:provider/provider.dart';
import 'app/pages/home/home_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final apiClient = ApiClient(client: http.Client());

  @override
  Widget build(BuildContext context) {
    final themeBloc = ThemeBloc();
    return StreamBuilder<ThemeData>(
      initialData: ThemeData(
        backgroundColor: Colors.blueGrey,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      stream: themeBloc.theme,
      builder: (context, snapshot) => MultiProvider(
        providers: [
          Provider.value(
            value: themeBloc,
            child: HomePage(),
          ),
          Provider<CovidRepository>.value(
              value: CovidRepository(client: apiClient)),
          Provider<ContinentBloc>(
            create: (_) =>
                ContinentBloc(repo: CovidRepository(client: apiClient)),
          ),
          Provider<CountryBloc>(
            create: (_) =>
                CountryBloc(repo: CovidRepository(client: apiClient)),
          ),
          Provider(
            create: (_) => SelectedCountryBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Zigzag Tech Exam',
          debugShowCheckedModeBanner: false,
          theme: snapshot.data,
          home: HomePage(),
        ),
      ),
    );
  }
}
