part of 'characters_list_bloc.dart';

abstract class CharactersListState {
  CharacterListModel characterList;
  CharactersListState({required this.characterList});
}

class LoadingState extends CharactersListState {
  LoadingState({required CharacterListModel characterList})
      : super(characterList: characterList);
}

class CharacterListLoaded extends CharactersListState {
  CharacterListLoaded({required CharacterListModel characterList})
      : super(characterList: characterList);
}

class LoadingMoreState extends CharacterListLoaded {
  LoadingMoreState({required CharacterListModel characterList})
      : super(characterList: characterList);
}

class ErrorLoadedState extends CharactersListState {
  String message;
  ErrorLoadedState(
      {required CharacterListModel characterList, required this.message})
      : super(characterList: characterList);
}
