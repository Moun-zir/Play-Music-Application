class Music {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String genre;
  final String coverImageUrl;
  // final int duration;
  final String fileUrl;
  final int likes;
  // final int plays;
 

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.genre,
    required this.coverImageUrl,
    // required this.duration,
    required this.fileUrl,
    required this.likes,
    // required this.plays,
  
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      artist: json['artist'] ?? 'Unknown Artist',
      album: json['album'],
      genre: json['genre'],
      coverImageUrl: json['coverImageUrl'] ?? '',
      // duration: json['duration'],
      fileUrl: json['fileUrl'],
      likes: json['likes'] ?? 0,
      // plays: json['plays'],

    );
  }

  
}