part of 'search_characters_bloc.dart';

abstract class SearchCharactersEvent {}

class ClearResultsEvent extends SearchCharactersEvent{}

class SearchCharacterEvent extends SearchCharactersEvent {
  String name;
  SearchCharacterEvent({
    required this.name,
  });
}
