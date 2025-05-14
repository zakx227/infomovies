class Cast {
  int? id;
  final String name;
  final String profilePath;

  Cast({required this.name, required this.profilePath, this.id});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }
}
