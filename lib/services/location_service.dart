import 'package:rick_and_morty_challenge/utils/http_request.dart';

const baseUrl = 'https://rickandmortyapi.com/api/location';

class LocationServie {
  final JHttpRequest _jHttpRequest;
  LocationServie(this._jHttpRequest);

  Future<JResponse> getLocations({String url = baseUrl}) async {
    final response = await _jHttpRequest.getRequest(url);
    return response;
  }
}
