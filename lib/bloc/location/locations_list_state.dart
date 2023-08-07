// ignore_for_file: prefer_const_constructors_in_immutables

part of 'locations_list_bloc.dart';

abstract class LocationsListState extends Equatable {
  final LocationListModel locationListModel;
  LocationsListState({
    required this.locationListModel,
  });
}

class LoadingState extends LocationsListState {
  LoadingState({required LocationListModel locationListModel})
      : super(locationListModel: locationListModel);

  @override
  List<Object?> get props => [locationListModel];
}

class LocationListLoaded extends LocationsListState {
  LocationListLoaded({required LocationListModel locationListModel})
      : super(locationListModel: locationListModel);

  @override
  List<Object?> get props => [locationListModel];
}

class LoadingMoreState extends LocationsListState {
  LoadingMoreState({required LocationListModel locationListModel})
      : super(locationListModel: locationListModel);

  @override
  List<Object?> get props => [locationListModel];
}

class ErrorLoadedState extends LocationsListState {
  final String message;
  ErrorLoadedState({
    required LocationListModel locationListModel,
    required this.message,
  }) : super(locationListModel: locationListModel);

  @override
  List<Object?> get props => [message, locationListModel];
}
