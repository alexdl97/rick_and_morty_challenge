import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/bloc/location/locations_list_bloc.dart';
import 'package:rick_and_morty_challenge/models/location.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/screens/widgets/location_card.dart';
import 'package:rick_and_morty_challenge/screens/widgets/skeleton_list_item_card.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  late LocationsListBloc _locationsListBloc;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _locationsListBloc = BlocProvider.of<LocationsListBloc>(context);
    _scrollController.addListener(() {
      if (_locationsListBloc.state is LoadingState ||
          _locationsListBloc.state is LoadingMoreState) return;
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 10)) {
        _locationsListBloc.add(GetMoreLocationsEvent());
      }
    });
    _getLocations();
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
        title: const Text('Locations'),
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
      body: BlocBuilder<LocationsListBloc, LocationsListState>(
          bloc: _locationsListBloc,
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

            final List<LocationModel> locations =
                snapshot.locationListModel.locations;
            if (locations.isEmpty) {
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
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return LocationCard(
                          name: locations[index].name!,
                          dimension: locations[index].dimension!,
                          type: locations[index].type!,
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

  void _getLocations() {
    _locationsListBloc.add(GetLocationsEvent());
  }
}
