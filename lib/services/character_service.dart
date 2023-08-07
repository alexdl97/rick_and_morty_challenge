import 'package:rick_and_morty_challenge/utils/http_request.dart';

const baseUrl = 'https://rickandmortyapi.com/api/character';

class CharacterService {
  final JHttpRequest _jHttpRequest;
  CharacterService(this._jHttpRequest);

  Future<JResponse> getCharacters({String url = baseUrl}) async {
    final response = await _jHttpRequest.getRequest(url);
    return response;
  }

  Future<JResponse> searchCharacter(String name) async {
    final response = await _jHttpRequest.getRequest(baseUrl, params: {'name': name});
    return response;
  }
}
