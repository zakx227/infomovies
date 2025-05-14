import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/providers/provider.dart';
import 'package:infomovis/screens/detail_screen.dart';
import 'package:infomovis/utils/constants.dart';

class ActorDetailScreen extends ConsumerWidget {
  final int actorId;
  const ActorDetailScreen({super.key, required this.actorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorDetail = ref.watch(actorDetailProvider(actorId));
    final actorMovies = ref.watch(actorMoviesProvider(actorId));
    log(actorDetail.toString());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: bgColor,
        title: const Text(
          "Acteur",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: actorDetail.when(
        data:
            (actor) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  actor.name!,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  actor.biography!,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Films',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      actorMovies.when(
                        data:
                            (movies) => SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => DetailScreen(
                                                movieId: movie.id as int,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      width: 120,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                              height: 150,
                                              width: 120,
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  (context, url) =>
                                                      const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            movie.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error: (e, _) => const Text('Erreur'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
      ),
    );
  }
}
