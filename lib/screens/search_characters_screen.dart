import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/search_characters/search_characters_bloc.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/screens/widgets/skeleton_box.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';

class SearchCharactersScreen extends StatefulWidget {
  const SearchCharactersScreen({super.key});

  @override
  State<SearchCharactersScreen> createState() => _SearchCharactersScreenState();
}

class _SearchCharactersScreenState extends State<SearchCharactersScreen> {
  late SearchCharactersBloc _searchCharactersBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchCharactersBloc = BlocProvider.of<SearchCharactersBloc>(context);
    _searchCharactersBloc.add(ClearResultsEvent());
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        onChanged: _onChangeSearch,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          //helperText: 'Search a character',
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.white),
                          labelText: 'Search a character',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Auth.logout();
                          Navigator.pushReplacementNamed(
                              context, RoutesApp.loginScreen);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ),
          BlocBuilder<SearchCharactersBloc, SearchCharactersState>(
              bloc: _searchCharactersBloc,
              builder: (context, snapshot) {
                if (snapshot is LoadingState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SkeletonBox(
                                height: 50,
                                width: 50,
                                radiusCircular: 6,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: SkeletonBox(
                                  height: 50,
                                  width: double.infinity,
                                  radiusCircular: 6,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                if (snapshot is ErrorLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      snapshot.message,
                      style: const TextStyle(color: Colors.grey, fontSize: 24),
                    ),
                  );
                }
                final characters = snapshot.characterList.characters;
                if (characters.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'No results',
                      style: TextStyle(color: Colors.grey, fontSize: 24),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(4),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesApp.characterDetailScreen,
                            arguments: characters[index],
                          );
                        },
                        title: Text(characters[index].name!),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Hero(
                            tag: characters[index].id.toString(),
                            child: FadeInImage(
                              fit: BoxFit.fill,
                              //width: double.infinity,
                              //height: double.infinity,
                              placeholder: const AssetImage(
                                'assets/loading.gif',
                              ),
                              image: NetworkImage(characters[index].image!),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  void _onChangeSearch(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchCharactersBloc.add(SearchCharacterEvent(name: text));
      //FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}
