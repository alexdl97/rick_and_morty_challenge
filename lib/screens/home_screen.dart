import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/screens/widgets/menu_option.dart';
import 'package:rick_and_morty_challenge/screens/widgets/skeleton_box.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size? size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Rick and Morty')),
        actions: [
          IconButton(
            onPressed: () {
              Auth.logout();
              Navigator.pushReplacementNamed(context, RoutesApp.loginScreen);
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          MenuOption(
            title: 'Characters',
            assetImage: 'assets/characters.jpg',
            onTap: () =>
                Navigator.pushNamed(context, RoutesApp.charactersScreen),
          ),
          const SizedBox(height: 16),
          MenuOption(
            title: 'Episodes',
            assetImage: 'assets/episode.jpg',
            onTap: () => Navigator.pushNamed(context, RoutesApp.episodesScreen),
          ),
          const SizedBox(height: 16),
          MenuOption(
            title: 'Search Characters',
            assetImage: 'assets/search_characters.webp',
            onTap: () => Navigator.pushNamed(context, RoutesApp.searchCharactersScreen),
          ),
          const SizedBox(height: 16),
          MenuOption(
            title: 'Locations',
            assetImage: 'assets/locations.jpeg',
            onTap: () =>
                Navigator.pushNamed(context, RoutesApp.locationsScreen),
          ),
        ],
      ),
    );
  }
}
