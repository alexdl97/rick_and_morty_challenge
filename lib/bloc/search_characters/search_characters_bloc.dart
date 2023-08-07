import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_challenge/models/character.dart';
import 'package:rick_and_morty_challenge/services/character_service.dart';

part 'search_characters_event.dart';
part 'search_characters_state.dart';

class SearchCharactersBloc
    extends Bloc<SearchCharactersEvent, SearchCharactersState> {
  final CharacterService _characterService;
  SearchCharactersBloc(this._characterService)
      : super(SearchLoadedState(
          characterList: CharacterListModel(),
        )) {
    on<ClearResultsEvent>((event, emit) async {
      emit(SearchLoadedState(characterList: CharacterListModel()));
    });
    on<SearchCharacterEvent>((event, emit) async {
      try {
        emit(LoadingState(characterList: state.characterList));
        if (event.name.isEmpty) {
          emit(SearchLoadedState(characterList: CharacterListModel()));
          return;
        }
        final response = await _characterService.searchCharacter(event.name);
        if (response.statusCode == 200) {
          CharacterListModel characterList =
              CharacterListModel.fromJson(response.data);
          emit(SearchLoadedState(characterList: characterList));
        } else {
          ErrorLoadedState(
            characterList: state.characterList,
            message: 'Ocurrió un problema al realizar la petición.',
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
