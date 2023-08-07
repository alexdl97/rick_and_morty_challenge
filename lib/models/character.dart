class CharacterListModel {
  int? count;
  int? pages;
  String? next;
  String? prev;
  List<CharacterModel> characters = [];

  CharacterListModel({this.count = 0, this.pages = 0, this.next, this.prev});

  CharacterListModel.fromJson(Map<String, dynamic> jsonResult) {
    if (jsonResult.containsKey('info')) {
      count = jsonResult['info']['count'];
      pages = jsonResult['info']['pages'];
      next = jsonResult['info']['next'];
      prev = jsonResult['info']['prev'];
    }

    if (jsonResult.containsKey('results')) {
      for (var json in jsonResult['results']) {
        characters.add(CharacterModel.fromJson(json));
      }
    }
  }
}

class CharacterModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  CharacterInfo? origin;
  CharacterInfo? location;
  String? image;
  List<String>? episodes;
  String? url;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episodes,
    this.url,
  });

  CharacterModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> episodeList =
        json.containsKey('episode') ? json['episode'] : [];
    id = json.containsKey('id') ? json['id'] : '';
    name = json.containsKey('name') ? json['name'] : '';
    status = json.containsKey('status') ? json['status'] : '';
    species = json.containsKey('species') ? json['species'] : '';
    type = json.containsKey('type') ? json['type'] : '';
    gender = json.containsKey('gender') ? json['gender'] : '';
    origin = CharacterInfo.fromJson(json['origin']);
    location = CharacterInfo.fromJson(json['location']);
    image = json.containsKey('image') ? json['image'] : '';
    episodes = episodeList.map((e) => e as String).toList();
    url = json.containsKey('url') ? json['url'] : '';
  }
}

class CharacterInfo {
  String? name;
  String? url;

  CharacterInfo({this.name, this.url});

  CharacterInfo.fromJson(Map<String, dynamic> json) {
    name = json.containsKey('name') ? json['name'] : '';
    url = json.containsKey('url') ? json['url'] : '';
  }
}
