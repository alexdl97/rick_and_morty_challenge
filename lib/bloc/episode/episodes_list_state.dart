// ignore_for_file: must_be_immutable

part of 'episodes_list_bloc.dart';

abstract class EpisodesListState extends Equatable {
  EpisodeListModel episodeListModel;
  EpisodesListState({
    required this.episodeListModel,
  });
}

class LoadingState extends EpisodesListState {
  LoadingState({
    required EpisodeListModel episodeListModel,
  }) : super(episodeListModel: episodeListModel);

  @override
  List<Object?> get props => [episodeListModel];
}

class ListLoadedState extends EpisodesListState {
  ListLoadedState({
    required EpisodeListModel episodeListModel,
  }) : super(episodeListModel: episodeListModel);

  @override
  List<Object?> get props => [episodeListModel];
}

class LoadingMoreState extends EpisodesListState {
  LoadingMoreState({
    required EpisodeListModel episodeListModel,
  }) : super(episodeListModel: episodeListModel);

  @override
  List<Object?> get props => [episodeListModel];
}

class ErrorLoadedState extends EpisodesListState {
  String message;
  ErrorLoadedState({
    required this.message,
    required EpisodeListModel episodeListModel,
  }) : super(episodeListModel: episodeListModel);

  @override
  List<Object?> get props => [message, episodeListModel];
}
