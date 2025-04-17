class Cast {
  final String name;
  final String profilePath;

  Cast({required this.name, required this.profilePath});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }
}
