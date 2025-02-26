class Playlist {
  final int id;
  final String name;
  final String description;
  final String coverUrl;
  final int userId;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.userId,
  });

  // Convertir JSON -> Objet Playlist
  factory Playlist.fromJson(Map<String, dynamic> json) {
  return Playlist(
    id: json['id'],
    name: json['name'],
    description: json['description'] ?? '',
    coverUrl: json['coverUrl'] ?? 'assets/images/gojo.jpeg',  // Image par défaut
    userId: json['userId'],
  );
}


  // Convertir Objet Playlist -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverUrl': coverUrl,
      'userId': userId,
    };
  }
}
