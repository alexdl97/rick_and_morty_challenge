import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/screens/widgets/skeleton_box.dart';

class SkeletonListItemCard extends StatelessWidget {

  const SkeletonListItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
              child: SkeletonBox(
                height: double.infinity,
                width: double.infinity,
              ),
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
                  SkeletonBox(height: 20, width: size.width * 0.3),
                  SkeletonBox(height: 20, width: size.width * 0.6),
                  SkeletonBox(height: 20, width: size.width * 0.4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
