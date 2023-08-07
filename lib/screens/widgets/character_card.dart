import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  const CharacterCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black45,
          //     blurRadius: 2,
          //     offset: Offset(0, 0),
          //     spreadRadius: 2,
          //   ),
          // ],
          border: Border.all(color: Colors.black26)),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: SizedBox(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Hero(
                  tag: id,
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    width: double.infinity,
                    placeholder: const AssetImage(
                      'assets/loading.gif',
                    ),
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
