import 'package:flutter/material.dart';

const episodeImageUrl =
    'https://hips.hearstapps.com/hmg-prod/images/rick-and-morty-1604562846.jpg?crop=0.530xw:1.00xh;0.202xw,0&resize=1200:*';

class EpisodeCard extends StatelessWidget {
  final String name;
  final String airDate;
  final String episode;
  const EpisodeCard({
    required this.name,
    required this.airDate,
    required this.episode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 4,
              offset: Offset(0, 1),
            )
          ]),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image(image: AssetImage('assets/episode.jpg'), fit: BoxFit.cover,),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  Text(airDate),
                ],
              ),
            ),
          ),
          Container(
            //color: Colors.red,
            margin: const EdgeInsets.only(right: 4),
            width: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.star_border,
                  size: 30,
                ),
                Icon(
                  Icons.favorite_border,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
