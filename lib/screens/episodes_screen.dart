import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/episode/episodes_list_bloc.dart';
import 'package:rick_and_morty_challenge/models/episode.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/screens/widgets/episode_card.dart';
import 'package:rick_and_morty_challenge/screens/widgets/skeleton_list_item_card.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  late EpisodesListBloc _episodesListBloc;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _episodesListBloc = BlocProvider.of<EpisodesListBloc>(context);
    _scrollController.addListener(() {
      if (_episodesListBloc.state is LoadingState ||
          _episodesListBloc.state is LoadingMoreState) return;
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 10)) {
        _episodesListBloc.add(GetMoreEpisodesEvent());
      }
    });
    _getEpisodes();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
        actions: [
          IconButton(
            onPressed: () {
              Auth.logout();
              Navigator.pushReplacementNamed(context, RoutesApp.loginScreen);
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: BlocBuilder<EpisodesListBloc, EpisodesListState>(
          bloc: _episodesListBloc,
          builder: (context, snapshot) {
            if (snapshot is LoadingState) {
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const SkeletonListItemCard();
                  });
            }
            if (snapshot is ErrorLoadedState) {
              return Center(
                child: Text(
                  snapshot.message,
                  style: const TextStyle(color: Colors.grey, fontSize: 24),
                ),
              );
            }
            final List<EpisodeModel> episodes =
                snapshot.episodeListModel.episodes;

            if (episodes.isEmpty) {
              return const Center(
                child: Text(
                  'No results',
                  style: TextStyle(color: Colors.grey, fontSize: 24),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: episodes.length,
                      itemBuilder: (context, index) {
                        return EpisodeCard(
                          name: episodes[index].name!,
                          airDate: episodes[index].airDate!,
                          episode: episodes[index].episode!,
                        );
                      }),
                ),
                if (snapshot is LoadingMoreState)
                  const CircularProgressIndicator()
              ],
            );
          }),
    );
  }

  void _getEpisodes() {
    _episodesListBloc.add(GetEpisodesEvent());
  }
}
