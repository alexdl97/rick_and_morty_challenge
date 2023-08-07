import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_challenge/models/episode.dart';
import 'package:rick_and_morty_challenge/services/episode_service.dart';

part 'epidodes_list_event.dart';
part 'episodes_list_state.dart';

class EpisodesListBloc extends Bloc<EpisodesListEvent, EpisodesListState> {
  final EpisodeServie _episodeServie;

  EpisodesListBloc(this._episodeServie)
      : super(LoadingState(
          episodeListModel: EpisodeListModel(),
        )) {
    on<GetEpisodesEvent>((event, emit) async {
      try {
        emit(LoadingState(
          episodeListModel: state.episodeListModel,
        ));
        final response = await _episodeServie.getEpisodes();
        print('STATUS ${response.statusCode}');
        //print('RESPONSE ${response.data}');
        if (response.statusCode == 200) {
          print('ES 200');
          EpisodeListModel episodeListModel = EpisodeListModel.fromJson(response.data);
          print('LENGTH ${episodeListModel.episodes.length}');
          emit(ListLoadedState(episodeListModel: episodeListModel));
        } else {
          print('NO ES 200');
          emit(
            ErrorLoadedState(
              message: 'Ocurrió un problema al realizar la petición.',
              episodeListModel: state.episodeListModel,
            ),
          );
        }
      } on SocketException {
        emit(
          ErrorLoadedState(
            message: 'Error de conexión, revisa tu conexión a internet.',
            episodeListModel: state.episodeListModel,
          ),
        );
      } catch (e) {
        emit(
          ErrorLoadedState(
            message: 'Ocurrió un problema al realizar la petición.',
            episodeListModel: state.episodeListModel,
          ),
        );
      }
    });
    on<GetMoreEpisodesEvent>(
      (event, emit) async {
        try {
          emit(LoadingMoreState(episodeListModel: state.episodeListModel));
          final response = await _episodeServie.getEpisodes(
              url: state.episodeListModel.next!);
          if (response.statusCode == 200) {
            EpisodeListModel episodeListModel =
                EpisodeListModel.fromJson(response.data);
            episodeListModel.episodes = [
              ...state.episodeListModel.episodes,
              ...episodeListModel.episodes
            ];
            emit(ListLoadedState(episodeListModel: episodeListModel));
          } else {
            emit(
              ErrorLoadedState(
                episodeListModel: state.episodeListModel,
                message: 'Ocurrió un problema al realizar la petición.',
              ),
            );
          }
        } on SocketException {
          emit(
            ErrorLoadedState(
              message: 'Error de conexión, revisa tu conexión a internet.',
              episodeListModel: state.episodeListModel,
            ),
          );
        } catch (e) {
          emit(
            ErrorLoadedState(
              message: 'Ocurrió un problema al realizar la petición.',
              episodeListModel: state.episodeListModel,
            ),
          );
        }
      },
    );
  }
}
