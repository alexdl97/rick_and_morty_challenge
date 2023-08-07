import 'package:rick_and_morty_challenge/utils/http_request.dart';

const baseUrl = 'https://rickandmortyapi.com/api/episode';

class EpisodeServie {
  final JHttpRequest _jHttpRequest;
  EpisodeServie(this._jHttpRequest);

  Future<JResponse> getEpisodes({String url = baseUrl}) async {
    final response = await _jHttpRequest.getRequest(url);
    return response;
  }
}
