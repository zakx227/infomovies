import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/providers/provider.dart';
import 'package:infomovis/utils/constants.dart';
import 'package:infomovis/widgets/card_movie.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(popularMovieProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bgColor,
        title: Text(
          'InfoFilms Popular',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: bgColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: movies.when(
          data: (movie) {
            return ListView.builder(
              itemCount: movie.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: CardMovie(
                      title: movie[index].title,
                      date: movie[index].releaseDate,
                      lang: movie[index].originalLanguage,
                      note: movie[index].voteCount.toString(),
                      img: movie[index].posterPath,
                    ),
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: movie[index].id,
                        ),
                  ),
                );
              },
            );
          },
          error:
              (error, _) => Center(
                child: Text(
                  'Erreur : $error',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          loading:
              () => Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
        ),
      ),
    );
  }
}
