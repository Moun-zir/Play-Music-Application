import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_model.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.blueGrey[900], // Couleur de fond sombre
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(playlist.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            ...playlist.songs.map((song) => ListTile(
              title: Text(song.title, style: const TextStyle(color: Colors.white)),
              subtitle: Text('${song.artist} • ${song.duration}', style: TextStyle(color: Colors.blueGrey[300])),
            )).toList(),
          ],
        ),
      ),
    );
  }
}