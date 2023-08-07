// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EpisodeListModel extends Equatable {
  int? count;
  int? pages;
  String? next;
  String? prev;
  List<EpisodeModel> episodes = [];

  EpisodeListModel({
    this.count = 0,
    this.pages = 0,
    this.next,
    this.prev,
  });

  EpisodeListModel.fromJson(Map<String, dynamic> jsonResult) {
    if (jsonResult.containsKey('info')) {
      count = jsonResult['info']['count'];
      pages = jsonResult['info']['pages'];
      next = jsonResult['info']['next'];
      prev = jsonResult['info']['prev'];
    }

    if (jsonResult.containsKey('results')) {
      for (var json in jsonResult['results']) {
        episodes.add(EpisodeModel.fromJson(json));
      }
    }
  }

  @override
  List<Object?> get props => [count, pages, next, prev, episodes];
}

class EpisodeModel extends Equatable {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;

  EpisodeModel({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
  });

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> charactersList =
        json.containsKey('characters') ? json['characters'] : [];
    id = json.containsKey('id') ? json['id'] : 0;
    name = json.containsKey('name') ? json['name'] : '';
    airDate = json.containsKey('air_date') ? json['air_date'] : '';
    episode = json.containsKey('episode') ? json['episode'] : '';
    characters = charactersList.map((e) => e as String).toList();
    url = json.containsKey('url') ? json['url'] : '';
  }

  @override
  List<Object?> get props => [id, name, airDate, episode, characters, url];
}
