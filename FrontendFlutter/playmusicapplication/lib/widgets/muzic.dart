import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_mod.dart';

class MusicCard extends StatelessWidget {
  final Music music;
  final VoidCallback onTap;

  const MusicCard({required this.music, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
  leading: ClipRRect(
    borderRadius: BorderRadius.circular(10), 
    child: Image.network(
      music.coverUrl,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    ),
  ),
  title: Text(music.title, style: TextStyle(color: Colors.white)),
  subtitle: Text(music.artist, style: TextStyle(color: Colors.grey)),
  onTap: onTap,
);
  }
}