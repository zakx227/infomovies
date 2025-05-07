import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/models/cast.dart';
import 'package:infomovis/models/movie.dart';
import 'package:infomovis/models/video.dart';
import 'package:infomovis/providers/favorites_provider.dart';
import 'package:infomovis/services/movie_api_service.dart';

final apiProvider = Provider<MovieApiService>((ref) => MovieApiService());

final popularMovieProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.watch(apiProvider).fetchMovies();
});

final searcheQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = FutureProvider<List<Movie>>((ref) {
  final query = ref.watch(searcheQueryProvider);
  if (query.isEmpty) {
    return Future.value([]);
  }
  return ref.watch(apiProvider).searchMovies(query);
});

final movieDetailProvider = FutureProvider.family<Movie, int>((ref, id) async {
  return ref.watch(apiProvider).fetchMovieDetail(id);
});

final movieNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, List<Movie>>((ref) {
      return FavoritesNotifier();
    });

final movieCastProvider = FutureProvider.family<List<Cast>, int>((
  ref,
  id,
) async {
  return ref.watch(apiProvider).fetchMovieCast(id);
});

final movieVideoProvider = FutureProvider.family<List<Video>, int>((
  ref,
  movieId,
) async {
  return ref.watch(apiProvider).fetchMovieVideos(movieId);
});
