import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_model.dart';
import 'package:playmusicapplication/widgets/playlist.dart';


class MusicPlayerScreen extends StatelessWidget {
  final List<Playlist> playlists = [
    Playlist(
      name: 'OnlyFans',
      songs: [
        Song(title: 'Isam Ft Kooroah', artist: 'Redbull', duration: '1:53',  genre: 'Pop'),
        Song(title: 'Arta Ft Kooroah & Smokepurpp', artist: 'Nakhla', duration: '4:42',  genre: 'Pop'),
      ],
    ),
    Playlist(
      name: 'Baaqbooli',
      songs: [
        Song(title: 'Hiphopologist x Kagan', artist: 'ttrptt', duration: '3:15',  genre: 'Pop'),
        Song(title: 'Poori', artist: 'First Class', duration: '2:30',  genre: 'Pop'),
      ],
    ),
    Playlist(
      name: 'Nakhla',
      songs: [
        Song(title: 'Kooroah 420VII', artist: 'Nakhla', duration: '5:00', genre: 'Pop'),
        Song(title: 'Face Sekte', artist: 'Hidden & Khalse & Sijal', duration: '4:10',  genre: 'Pop'),
      ],
    ),
    Playlist(
      name: 'Ma',
      songs: [
        Song(title: 'CatchyBeats Ft 021Kid', artist: 'Ma', duration: '3:45', genre: 'Pop'),
        Song(title: 'Kooroah Ft Sami Low', artist: 'Dobareh', duration: '4:20', genre: 'Pop'),
      ],
    ),
    Playlist(
      name: 'Inja Irane',
      songs: [
        Song(title: 'Gogooah Ft Sogaard & Leila Forohar', artist: 'Inja Irane', duration: '3:50', genre: 'Pop'),
        Song(title: 'Nakhla', artist: 'Hidden & Khalse & Sijal', duration: '4:00', genre: 'Pop'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        color: Colors.blueGrey[800], // Couleur de fond de l'écran
        child: ListView(
          children: playlists.map((playlist) => PlaylistCard(playlist: playlist)).toList(),
        ),
      ),
    );
  }
}