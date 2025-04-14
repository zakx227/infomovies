class Movie {
  int? id;
  String title;
  String releaseDate;
  String posterPath;
  String overview;
  String originalLanguage;
  int voteCount;

  Movie({
    this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.overview,
    required this.originalLanguage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Titre inconnu',
      releaseDate: json['release_date'] ?? 'Date inconnu',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? 'Inconnu',
      originalLanguage: json['original_language'] ?? 'Language inconnu',
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'poster_path': posterPath,
      'overview': overview,
      'original_language': originalLanguage,
      'vote_count': voteCount,
    };
  }
}
