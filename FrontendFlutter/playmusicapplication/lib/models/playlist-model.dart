import 'package:playmusicapplication/models/music-model.dart';

class Playlist {
  final int id;
  final String name;
  final String description;
  final String coverUrl;
  final DateTime createdAt;
  final List<Music> musicContent;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.createdAt,
    required this.musicContent,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverUrl: json['coverUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      musicContent: (json['musicContent'] as List)
          .map((m) => Music.fromJson(m))
          .toList(),
    );
  }
}