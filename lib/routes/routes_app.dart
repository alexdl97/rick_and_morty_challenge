
import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/screens/character_detail_screen.dart';
import 'package:rick_and_morty_challenge/screens/characters_screen.dart';
import 'package:rick_and_morty_challenge/screens/episodes_screen.dart';
import 'package:rick_and_morty_challenge/screens/home_screen.dart';
import 'package:rick_and_morty_challenge/screens/locations_screen.dart';
import 'package:rick_and_morty_challenge/screens/login_screen.dart';
import 'package:rick_and_morty_challenge/screens/search_characters_screen.dart';

class RoutesApp {

  static const String loginScreen = 'login';
  static const String homeScreen = 'home';
  static const String charactersScreen = 'characters';
  static const String episodesScreen = 'episodes';
  static const String searchCharactersScreen = 'search';
  static const String characterDetailScreen = 'character_detail';
  static const String locationsScreen = 'locations';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      RoutesApp.loginScreen: (_) => const LoginScreen(),
      RoutesApp.homeScreen: (_) => const HomeScreen(),
      RoutesApp.charactersScreen: (_) => const CharactersScreen(),
      RoutesApp.episodesScreen: (_) => const EpisodesScreen(),
      RoutesApp.searchCharactersScreen: (_) => const SearchCharactersScreen(),
      RoutesApp.characterDetailScreen: (_) => const CharacterDetailScreen(),
      RoutesApp.locationsScreen: (_) => const LocationsScreen(),
    };
  }
}
