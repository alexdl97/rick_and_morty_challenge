// ignore_for_file: must_be_immutable

part of 'characters_list_bloc.dart';

@immutable
abstract class CharactersListState extends Equatable {
  CharacterListModel characterList;
  CharactersListState({required this.characterList});
}

class LoadingState extends CharactersListState {
  LoadingState({required CharacterListModel characterList})
      : super(characterList: characterList);

  @override
  List<Object?> get props => [characterList];
}

class CharacterListLoaded extends CharactersListState {
  CharacterListLoaded({required CharacterListModel characterList})
      : super(characterList: characterList);

  @override
  List<Object?> get props => [characterList];
}

class LoadingMoreState extends CharacterListLoaded {
  LoadingMoreState({required CharacterListModel characterList})
      : super(characterList: characterList);

  @override
  List<Object?> get props => [characterList];
}

class ErrorLoadedState extends CharactersListState {
  String message;
  ErrorLoadedState(
      {required CharacterListModel characterList, required this.message})
      : super(characterList: characterList);

  @override
  List<Object?> get props => [message, characterList];
}
