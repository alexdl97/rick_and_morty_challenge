part of 'characters_list_bloc.dart';

abstract class CharactersListEvent {}

class GetCharactersEvent extends CharactersListEvent{
  GetCharactersEvent();
}

class GetMoreCharactersEvent extends CharactersListEvent{}