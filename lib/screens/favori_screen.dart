import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/providers/provider.dart';
import 'package:infomovis/utils/constants.dart';
import 'package:infomovis/widgets/card_movie.dart';

class FavoriScreen extends ConsumerWidget {
  const FavoriScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(movieNotifierProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'FavoriteFilms',
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          if (favorites.isEmpty) {
            return Center(
              child: Text(
                "Aucun favori ajouté.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: favorites[index].id,
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardMovie(
                title: favorites[index].title,
                date: favorites[index].releaseDate,
                lang: favorites[index].originalLanguage,
                note: favorites[index].voteCount.toString(),
                img: favorites[index].posterPath,
                favori: true,
                onPressed: () {
                  ref
                      .read(movieNotifierProvider.notifier)
                      .deletedMovie(favorites[index].id as int);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
