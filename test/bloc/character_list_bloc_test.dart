import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_challenge/bloc/characters/characters_list_bloc.dart';
import 'package:rick_and_morty_challenge/models/character.dart';
import 'package:rick_and_morty_challenge/services/character_service.dart';
import 'package:rick_and_morty_challenge/utils/http_request.dart';

import 'character_list_bloc_test.mocks.dart';

@GenerateMocks([CharacterService])
// import 'character_service.mocks.dart';

void main() {
  _charactersListBloc();
}

late MockCharacterService mockCharacterService;
late CharactersListBloc characterListBloc;
final CharacterListModel characterListModel = CharacterListModel();
void _charactersListBloc() {
  group('Characters List Bloc', () {
    mockCharacterService = MockCharacterService();
    characterListBloc = CharactersListBloc(mockCharacterService);

    when(mockCharacterService.getCharacters())
        .thenAnswer((realInvocation) async {
      dynamic data = {
        'info': {
          'count': characterListModel.count,
          'pages': characterListModel.pages,
          'next': characterListModel.next,
          'prev': characterListModel.prev,
        },
        'results': []
      };
      return JResponse(statusCode: 200, data: data);
    });
    blocTest<CharactersListBloc, CharactersListState>(
      'Get Characters',
      build: () => characterListBloc,
      act: (bloc) => bloc.add(GetCharactersEvent()),
      expect: () => [
        LoadingState(characterList: characterListModel),
        CharacterListLoaded(characterList: characterListModel)
      ],
      wait: const Duration(seconds: 1),
    );
  });
}
