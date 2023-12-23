import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:flutter/material.dart';

class ActorListView extends StatelessWidget {
  const ActorListView({
    super.key,
    required this.actorsList,
  });

  final List<Actor>? actorsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsList!.length,
        itemBuilder: (BuildContext context, int index) {
          final Actor actor = actorsList![index];

          return Container(
            padding: const EdgeInsets.all(5),
            width: 120,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: actor.profilePath == ""
                      ? Image.asset(
                          "assets/images/no-image-poster.png",
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          actor.profilePath,
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                ),
                Text(
                  actor.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                actor.character == null
                    ? const SizedBox()
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          actor.character!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
