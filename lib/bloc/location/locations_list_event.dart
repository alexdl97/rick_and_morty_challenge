part of 'locations_list_bloc.dart';

abstract class LocationsListEvent {}

class GetLocationsEvent extends LocationsListEvent {}

class GetMoreLocationsEvent extends LocationsListEvent {}
