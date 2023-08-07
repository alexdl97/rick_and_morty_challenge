import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_challenge/models/location.dart';
import 'package:rick_and_morty_challenge/services/location_service.dart';

part 'locations_list_state.dart';
part 'locations_list_event.dart';

class LocationsListBloc extends Bloc<LocationsListEvent, LocationsListState> {
  final LocationServie _locationServie;
  LocationsListBloc(this._locationServie)
      : super(LoadingState(locationListModel: LocationListModel())) {
    on<GetLocationsEvent>(_onGetLocationsEvent);
    on<GetMoreLocationsEvent>(_onGetMoreLocationsEvent);
  }

  void _onGetLocationsEvent(
      GetLocationsEvent event, Emitter<LocationsListState> emit) async {
    try {
      emit(LoadingState(locationListModel: state.locationListModel));
      final response = await _locationServie.getLocations();
      if (response.statusCode == 200) {
        LocationListModel locationList =
            LocationListModel.fromJson(response.data);
        emit(LocationListLoaded(locationListModel: locationList));
      } else {
        emit(ErrorLoadedState(
          locationListModel: state.locationListModel,
          message: 'Ocurrió un problema al realizar la petición.',
        ));
      }
    } on SocketException {
      emit(ErrorLoadedState(
        locationListModel: state.locationListModel,
        message: 'Error de conexión, revisa tu conexión a internet.',
      ));
    } catch (e) {
      emit(ErrorLoadedState(
        locationListModel: state.locationListModel,
        message: 'Ocurrió un problema al realizar la petición.',
      ));
    }
  }

  void _onGetMoreLocationsEvent(
      GetMoreLocationsEvent event, Emitter<LocationsListState> emit) async {
    try {
      emit(LoadingMoreState(locationListModel: state.locationListModel));
      final response = await _locationServie.getLocations(
          url: state.locationListModel.next!);
      if (response.statusCode == 200) {
        LocationListModel locationList =
            LocationListModel.fromJson(response.data);
        locationList.locations = [
          ...state.locationListModel.locations,
          ...locationList.locations
        ];
        emit(LocationListLoaded(locationListModel: locationList));
      } else {
        emit(ErrorLoadedState(
          locationListModel: state.locationListModel,
          message: 'Ocurrió un problema al realizar la petición.',
        ));
      }
    } on SocketException {
      emit(ErrorLoadedState(
        locationListModel: state.locationListModel,
        message: 'Error de conexión, revisa tu conexión a internet.',
      ));
    } catch (e) {
      emit(ErrorLoadedState(
        locationListModel: state.locationListModel,
        message: 'Ocurrió un problema al realizar la petición.',
      ));
    }
  }
}
