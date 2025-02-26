

class Music {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String genre;
  final String coverImageUrl;
  final int duration;
  final String fileUrl;
  final int likes;
  final int plays;
  final DateTime releaseDate;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.genre,
    required this.coverImageUrl,
    required this.duration,
    required this.fileUrl,
    required this.likes,
    required this.plays,
    required this.releaseDate,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      genre: json['genre'],
      coverImageUrl: json['coverImageUrl'],
      duration: json['duration'],
      fileUrl: json['fileUrl'],
      likes: json['likes'],
      plays: json['plays'],
      releaseDate: DateTime.parse(json['releaseDate']),
    );
  }
}