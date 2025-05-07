import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/models/video.dart';
import 'package:infomovis/providers/provider.dart';
import 'package:infomovis/utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
            return SingleChildScrollView(
              child: Column(
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
                            (context, url) => Container(
                              padding: EdgeInsets.all(110),
                              child: SizedBox(
                                height: 0,
                                width: 0,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data.title,
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.overview,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Casting',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ref
                      .watch(movieCastProvider(movieId))
                      .when(
                        data:
                            (castList) => SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: castList.length,
                                itemBuilder: (context, index) {
                                  final cast = castList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                          ),
                                          radius: 40,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          cast.name,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                        loading: () => CircularProgressIndicator(),
                        error: (e, _) => Text('Erreur cast : $e'),
                      ),
                  /*  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Bande-annonce',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),*/
                  /* ref
                      .watch(movieVideoProvider(movieId))
                      .when(
                        data: (videos) {
                          final trailer = videos.firstWhere(
                            (v) => v.site == 'YouTube' && v.type == 'Trailer',
                            orElse:
                                () => Video(
                                  key: '',
                                  name: '',
                                  site: '',
                                  type: '',
                                ),
                          );
              
                          if (trailer.key.isEmpty) {
                            return Text(
                              "Aucune bande-annonce disponible",
                              style: TextStyle(color: Colors.white),
                            );
                          }
              
                          return Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Image.network(
                                    'https://img.youtube.com/vi/${trailer.key}/0.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.play_circle_fill,
                                        color: Colors.white,
                                        size: 64,
                                      ),
                                      onPressed: () {
                                        launchUrl(
                                          Uri.parse(
                                            'https://www.youtube.com/watch?v=${trailer.key}',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        loading: () => CircularProgressIndicator(),
                        error:
                            (e, _) => Text(
                              'Erreur vidéo : $e',
                              style: TextStyle(color: Colors.white),
                            ),
                      ),*/
                  ref
                      .watch(movieVideoProvider(movieId))
                      .when(
                        data: (videos) {
                          final trailer = videos.firstWhere(
                            (v) => v.site == 'YouTube' && v.type == 'Trailer',
                            orElse:
                                () => Video(
                                  key: '',
                                  name: '',
                                  site: '',
                                  type: '',
                                ),
                          );

                          if (trailer.key.isEmpty) {
                            return Text(
                              "Aucune bande-annonce disponible",
                              style: TextStyle(color: Colors.white),
                            );
                          }

                          final YoutubePlayerController controller =
                              YoutubePlayerController(
                                initialVideoId: trailer.key,
                                flags: YoutubePlayerFlags(autoPlay: false),
                              );

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bande-annonce',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                YoutubePlayer(
                                  controller: controller,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.red,
                                  progressColors: ProgressBarColors(
                                    playedColor: Colors.red,
                                    handleColor: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loading: () => CircularProgressIndicator(),
                        error:
                            (e, _) => Text(
                              'Erreur vidéo : $e',
                              style: TextStyle(color: Colors.white),
                            ),
                      ),
                  Container(height: 90),
                ],
              ),
            );
          },
          error:
              (err, _) => Center(
                child: Text(
                  "Erreur : $err",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF032541),
        onPressed: () {
          movieDetail.when(
            data: (movie) {
              ref.read(movieNotifierProvider.notifier).addMovie(movie);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Film ajouté aux favoris!')),
              );
            },
            loading: () {},
            error: (err, _) {},
          );
        },

        child: Icon(Icons.favorite, color: Colors.white, size: 20),
      ),
    );
  }
}
