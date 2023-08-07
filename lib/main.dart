import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/characters/characters_list_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/episode/episodes_list_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/location/locations_list_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/search_characters/search_characters_bloc.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/services/character_service.dart';
import 'package:rick_and_morty_challenge/services/episode_service.dart';
import 'package:rick_and_morty_challenge/services/location_service.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';
import 'package:rick_and_morty_challenge/utils/http_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthenticate = await Auth.isAuthenticate();
  runApp(MyApp(isAuthenticate: isAuthenticate));
}

class MyApp extends StatelessWidget {
  final bool isAuthenticate;
  const MyApp({super.key, required this.isAuthenticate});

  @override
  Widget build(BuildContext context) {
    final JHttpRequest jHttpRequest = JHttpRequest();
    final CharacterService characterService = CharacterService(jHttpRequest);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CharactersListBloc(characterService)),
        BlocProvider(
            create: (_) => EpisodesListBloc(EpisodeServie(jHttpRequest))),
        BlocProvider(create: (_) => SearchCharactersBloc(characterService)),
        BlocProvider(
            create: (_) => LocationsListBloc(LocationServie(jHttpRequest))),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(151, 206, 76, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(151, 206, 76, 1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute:
            isAuthenticate ? RoutesApp.homeScreen : RoutesApp.loginScreen,
        routes: RoutesApp.getRoutes(),
      ),
    );
  }
}
