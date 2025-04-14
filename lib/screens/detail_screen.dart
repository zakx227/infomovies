import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/models/movie.dart';
import 'package:infomovis/providers/provider.dart';
import 'package:infomovis/utils/constants.dart';

class DetailScreen extends ConsumerWidget {
  final int movieId;
  const DetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'DetailFilms',
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: bgColor,
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: movieDetail.when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${data.posterPath}',
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) =>
                              CircularProgressIndicator(color: Colors.white),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Text(
                  data.title,
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
                Expanded(
                  child: Text(
                    data.overview,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Note : ${data.voteCount}',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (err, _) => Center(child: Text("Erreur : $err")),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF032541),
        onPressed: () {},
        child: Icon(Icons.favorite, color: Colors.white, size: 20),
      ),
    );
  }
}
