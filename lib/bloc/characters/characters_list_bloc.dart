import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_challenge/models/character.dart';
import 'package:rick_and_morty_challenge/services/character_service.dart';

part 'characters_list_state.dart';
part 'characters_list_event.dart';

class CharactersListBloc
    extends Bloc<CharactersListEvent, CharactersListState> {
  final CharacterService _characterService;

  CharactersListBloc(this._characterService)
      : super(LoadingState(characterList: CharacterListModel())) {
    on<GetCharactersEvent>((event, emit) async {
      try {
        emit(LoadingState(characterList: state.characterList));
        final response = await _characterService.getCharacters();
        if (response.statusCode == 200) {
          CharacterListModel characterList =
              CharacterListModel.fromJson(response.data);
          emit(CharacterListLoaded(characterList: characterList));
        } else {
          emit(
            ErrorLoadedState(
              characterList: state.characterList,
              message: 'Ocurrió un problema al realizar la petición.',
            ),
          );
        }
      } on SocketException {
        emit(
          ErrorLoadedState(
            characterList: state.characterList,
            message: 'Error de conexión, revisa tu conexión a internet.',
          ),
        );
      } catch (e) {
        emit(
          ErrorLoadedState(
            characterList: state.characterList,
            message: 'Ocurrió un problema al realizar la petición.',
          ),
        );
      }
    });
    on<GetMoreCharactersEvent>((event, emit) async {
      try {
        emit(LoadingMoreState(characterList: state.characterList));
        final response = await _characterService.getCharacters(
            url: state.characterList.next!);
        if (response.statusCode == 200) {
          CharacterListModel characterList =
              CharacterListModel.fromJson(response.data);
          characterList.characters = [
            ...state.characterList.characters,
            ...characterList.characters
          ];
          emit(CharacterListLoaded(characterList: characterList));
        } else {
          emit(
            ErrorLoadedState(
              characterList: state.characterList,
              message: 'Ocurrió un problema al realizar la petición.',
            ),
          );
        }
      } on SocketException {
        emit(
          ErrorLoadedState(
            characterList: state.characterList,
            message: 'Error de conexión, revisa tu conexión a internet.',
          ),
        );
      } catch (e) {
        emit(
          ErrorLoadedState(
            characterList: state.characterList,
            message: 'Ocurrió un problema al realizar la petición.',
          ),
        );
      }
    });
  }
}
