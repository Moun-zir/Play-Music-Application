import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_mod.dart';

class MusicPlayerScreen extends StatelessWidget {
  final Music music;

  const MusicPlayerScreen({required this.music, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 44, 68), // Bleu sombre
      appBar: AppBar(
        title: const Text("Music Player", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 40, 77, 107),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image arrondie
                ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Bordures arrondies
                  child: Image.network(
                    music.coverUrl, 
                    width: 350, 
                    height: 350, 
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(music.title, style: const TextStyle(color: Colors.white, fontSize: 24)),
                Text(music.artist, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                const SizedBox(height: 30),
                // Contrôles de lecture
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.volume_up, color: Colors.white), 
                      onPressed: () {}
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Colors.white), 
                      onPressed: () {}
                    ),
                    IconButton(
                      icon: const Icon(Icons.shuffle_rounded, color: Colors.white,), 
                      onPressed: () {}
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat, color: Colors.white), 
                      onPressed: () {}
                    ),
                      IconButton(
                      icon: const Icon(Icons.favorite_border_outlined, color: Colors.white), 
                      onPressed: () {}
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Barre de progression
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text('0:00', style: TextStyle(color: Colors.grey)),
                      Expanded(
                        child: Slider(
                          value: 0.5, // Valeur de progression
                          onChanged: (value) {},
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                        ),
                      ),
                      Text('3:30', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                // Contrôles supplémentaires rapprochés de la barre de progression
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 65,
                      icon: const Icon(Icons.skip_previous, color: Colors.white), 
                      onPressed: () {}
                    ),
                     IconButton(
                      iconSize: 65,
                      icon: const Icon(Icons.play_arrow, color: Colors.white), 
                      onPressed: () {}
                    ),
                      IconButton(
                        iconSize: 65,
                      icon: const Icon(Icons.skip_next, color: Colors.white), 
                      onPressed: () {}
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}