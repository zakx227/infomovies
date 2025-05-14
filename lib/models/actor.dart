class Actor {
  final String? name;
  final String? profilePath;
  final String? biography;

  Actor({
    required this.name,
    required this.profilePath,
    required this.biography,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      name: json['name'],
      profilePath: json['profile_path'],
      biography: json['biography'],
    );
  }
}
