import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/models/data/data_base_helper.dart';
import 'package:infomovis/models/movie.dart';

class FavoritesNotifier extends StateNotifier<List<Movie>> {
  final DataBaseHelper db = DataBaseHelper();
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favorites = await db.getAllData();
    state = favorites;
  }

  Future<void> addMovie(Movie movie) async {
    await db.insertData(movie);
    loadFavorites();
  }

  Future<void> deletedMovie(int id) async {
    await db.deleteData(id);
    loadFavorites();
  }
}
