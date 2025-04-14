import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/providers/provider.dart';
import 'package:infomovis/utils/constants.dart';
import 'package:infomovis/widgets/card_movie.dart';
import 'package:infomovis/widgets/search_field.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchMoviesProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: bgColor,
          title: Text(
            'SearchFilms',
            style: TextStyle(
              color: Colors.red,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SearchField(
                controller: searchController,
                onPressed: () {
                  ref.read(searcheQueryProvider.notifier).state =
                      searchController.text.trim();
                },
              ),
              Expanded(
                child: searchResults.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Center(
                        child: Text(
                          'Aucun film trouve',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  '/detail',
                                  arguments: data[index].id,
                                ),
                            child: CardMovie(
                              title: data[index].title,
                              date: data[index].releaseDate,
                              lang: data[index].originalLanguage,
                              note: data[index].voteCount.toString(),
                              img: data[index].posterPath,
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
                  loading: () => Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
