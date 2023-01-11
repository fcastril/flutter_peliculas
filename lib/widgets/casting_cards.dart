import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              margin: const EdgeInsets.only(bottom: 30),
              child: const CupertinoActivityIndicator(),
            );
          }

          final cast = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, int index) {
                return _CastCard(actor: cast[index]);
              },
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({super.key, required this.actor});
  @override
  Widget build(BuildContext context) {
    final TextTheme themeText = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 160,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(actor.fullProfilePath),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 140,
                )),
            const SizedBox(height: 5),
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            if (actor.character != null)
              Text(actor.character!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: themeText.caption)
          ],
        ));
  }
}
