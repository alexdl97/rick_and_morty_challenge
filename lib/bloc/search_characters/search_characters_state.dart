part of 'search_characters_bloc.dart';

abstract class SearchCharactersState {
  final CharacterListModel characterList;
  SearchCharactersState({
    required this.characterList,
  });
}

class LoadingState extends SearchCharactersState {
  LoadingState({
    required CharacterListModel characterList,
  }) : super(characterList: characterList);
}

class SearchLoadedState extends SearchCharactersState {
  SearchLoadedState({
    required CharacterListModel characterList,
  }) : super(characterList: characterList);
}

class ErrorLoadedState extends SearchCharactersState {
  String message;
  ErrorLoadedState({
    required this.message,
    required CharacterListModel characterList,
  }) : super(characterList: characterList);
}
