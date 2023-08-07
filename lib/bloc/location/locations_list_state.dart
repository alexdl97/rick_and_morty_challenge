part of 'locations_list_bloc.dart';

abstract class LocationsListState {
  final LocationListModel locationListModel;
  LocationsListState({
    required this.locationListModel,
  });
}

class LoadingState extends LocationsListState {
  LoadingState({required LocationListModel locationListModel})
      : super(locationListModel: locationListModel);
}

class LocationListLoaded extends LocationsListState {
  LocationListLoaded({required LocationListModel locationListModel})
      : super(locationListModel: locationListModel);
}

class LoadingMoreState extends LocationsListState {
  LoadingMoreState({required LocationListModel locationListModel})
      : super(locationListModel: locationListModel);
}

class ErrorLoadedState extends LocationsListState {
  final String message;
  ErrorLoadedState({
    required LocationListModel locationListModel,
    required this.message,
  }) : super(locationListModel: locationListModel);
}
