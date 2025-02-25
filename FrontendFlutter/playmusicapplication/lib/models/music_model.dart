// class Music {
//   final String title;
//   final String artist;
//   final String album;
//   final String genre;
//   final String coverImageUrl;
//   final String fileUrl;

//   Music({
//     required this.title,
//     required this.artist,
//     required this.album,
//     required this.genre,
//     required this.coverImageUrl,
//     required this.fileUrl,
//   });

//   // Méthode pour convertir un objet JSON en instance de Music
//   factory Music.fromJson(Map<String, dynamic> json) {
//     return Music(
//       title: json['title'],
//       artist: json['artist'],
//       album: json['album'],
//       genre: json['genre'],
//       coverImageUrl: json['coverImageUrl'],
//       fileUrl: json['fileUrl'],
//     );
//   }
// }

class Song {
  final String title;
  final String artist;
  final String genre;
  final String duration;

  Song({required this.title, required this.artist, required this.genre, required this.duration});
}

class Artist {
  final String name;
  final String country;
  final List<Song> topMix;
  final List<Song> recentlyPlayed;

  Artist({
    required this.name,
    required this.country,
    required this.topMix,
    required this.recentlyPlayed,
  });
}

class Playlist {
  final String name;
  final List<Song> songs;

  Playlist({required this.name, required this.songs});
}