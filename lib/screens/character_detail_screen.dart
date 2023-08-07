import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/models/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final character =
        ModalRoute.of(context)!.settings.arguments as CharacterModel;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Hero(
                  tag: character.id.toString(),
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    width: double.infinity,
                    placeholder: const AssetImage(
                      'assets/loading.gif',
                    ),
                    image: NetworkImage(character.image!),
                  ),
                ),
              ),
              SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    //spreadRadius: 1,
                  )
                ]),
            child: Column(
              children: [
                _rowInfo(
                  'Name:',
                  character.name!,
                ),
                const SizedBox(
                  height: 16,
                ),
                _rowInfo(
                  'Status:',
                  character.status!,
                ),
                const SizedBox(
                  height: 16,
                ),
                _rowInfo(
                  'Species:',
                  character.species!,
                ),
                const SizedBox(
                  height: 16,
                ),
                _rowInfo(
                  'Gender:',
                  character.gender!,
                ),
                const SizedBox(
                  height: 16,
                ),
                _rowInfo('Origin:', character.origin?.name ?? ''),
                const SizedBox(
                  height: 16,
                ),
                _rowInfo('Location:', character.origin?.name ?? ''),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _rowInfo(String title1, String info1) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title1,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          info1,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
