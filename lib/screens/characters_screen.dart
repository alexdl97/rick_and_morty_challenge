import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/characters/characters_list_bloc.dart';
import 'package:rick_and_morty_challenge/models/character.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/screens/widgets/character_card.dart';
import 'package:rick_and_morty_challenge/screens/widgets/skeleton_box.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late CharactersListBloc _charactersListBloc;
  Size? _size;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _charactersListBloc = BlocProvider.of<CharactersListBloc>(context);
    _scrollController.addListener(() {
      if (_charactersListBloc.state is LoadingState ||
          _charactersListBloc.state is LoadingMoreState) return;
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 10)) {
        _charactersListBloc.add(GetMoreCharactersEvent());
      }
    });
    _getCharacters();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
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
      body: BlocBuilder<CharactersListBloc, CharactersListState>(
          bloc: _charactersListBloc,
          builder: (context, snapshot) {
            if (snapshot is LoadingState) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 250,
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 9,
                itemBuilder: ((context, index) {
                  return const SkeletonBox(
                    height: double.infinity,
                    width: double.infinity,
                    radiusCircular: 10,
                  );
                }),
              );
            }

            if (snapshot is ErrorLoadedState) {
              return Center(
                child: Text(
                  snapshot.message,
                  style: const TextStyle(color: Colors.grey, fontSize: 24),
                ),
              );
            }

            final CharacterListModel characterList = snapshot.characterList;
            final List<CharacterModel> characters = characterList.characters;
            if (characters.isEmpty) {
              return const Center(
                child: Text(
                  'No results',
                  style: TextStyle(color: Colors.grey, fontSize: 24),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white38,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 250,
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: characters.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesApp.characterDetailScreen,
                                arguments: characters[index],
                              );
                            },
                            child: CharacterCard(
                              id: characters[index].id.toString(),
                              name: characters[index].name!,
                              imageUrl: characters[index].image!,
                            ),
                          );
                        }),
                  ),
                  if (snapshot is LoadingMoreState)
                    const CircularProgressIndicator()
                ],
              ),
            );
          }),
    );
  }

  void _getCharacters() {
    _charactersListBloc.add(GetCharactersEvent());
  }
}
