// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

part of 'search_characters_bloc.dart';

abstract class SearchCharactersState extends Equatable {
  final CharacterListModel characterList;
  SearchCharactersState({
    required this.characterList,
  });
}

class LoadingState extends SearchCharactersState {
  LoadingState({
    required CharacterListModel characterList,
  }) : super(characterList: characterList);

  @override
  List<Object?> get props => [characterList];
}

class SearchLoadedState extends SearchCharactersState {
  SearchLoadedState({
    required CharacterListModel characterList,
  }) : super(characterList: characterList);

  @override
  List<Object?> get props => [characterList];
}

class ErrorLoadedState extends SearchCharactersState {
  String message;
  ErrorLoadedState({
    required this.message,
    required CharacterListModel characterList,
  }) : super(characterList: characterList);

  @override
  List<Object?> get props => [message, characterList];
}
