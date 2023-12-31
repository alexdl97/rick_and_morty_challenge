// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class LocationListModel extends Equatable {
  int? count;
  int? pages;
  String? next;
  String? prev;
  List<LocationModel> locations = [];

  LocationListModel({
    this.count = 0,
    this.pages = 0,
    this.next,
    this.prev,
  });

  LocationListModel.fromJson(Map<String, dynamic> jsonResult) {
    if (jsonResult.containsKey('info')) {
      count = jsonResult['info']['count'];
      pages = jsonResult['info']['pages'];
      next = jsonResult['info']['next'];
      prev = jsonResult['info']['prev'];
    }

    if (jsonResult.containsKey('results')) {
      for (var json in jsonResult['results']) {
        locations.add(LocationModel.fromJson(json));
      }
    }
  }

  @override
  List<Object?> get props => [count, pages, next, prev, locations];
}

class LocationModel extends Equatable {
  int? id;
  String? name;
  String? type;
  String? dimension;
  int? numberOfResidents;

  LocationModel({
    this.id,
    this.name,
    this.type,
    this.dimension,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> residentsList =
        json.containsKey('residents') ? json['residents'] : [];
    id = json.containsKey('id') ? json['id'] : 0;
    name = json.containsKey('name') ? json['name'] : '';
    type = json.containsKey('type') ? json['type'] : '';
    dimension = json.containsKey('dimension') ? json['dimension'] : '';
    numberOfResidents = residentsList.length;
  }

  @override
  List<Object?> get props => [id, name, type, dimension, numberOfResidents];
}
