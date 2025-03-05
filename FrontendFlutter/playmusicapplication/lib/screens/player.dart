import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music-model.dart'; // Utilisez votre modèle Music
import 'package:audioplayers/audioplayers.dart';
import 'package:playmusicapplication/service/api_service.dart'; // Importer ApiService

class MusicPlayerScreen extends StatefulWidget {
  final Music music;

  const MusicPlayerScreen({required this.music, Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  final ApiService _apiService = ApiService(); // Instance d'ApiService

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    print('Attempting to play audio from URL: ${widget.music.fileUrl}');
    if (widget.music.fileUrl != null && widget.music.fileUrl!.isNotEmpty) {
      try {
        await _audioPlayer.setSource(UrlSource(widget.music.fileUrl!));
        _audioPlayer.onDurationChanged.listen((Duration d) {
          setState(() => _duration = d);
        });
        _audioPlayer.onPositionChanged.listen((Duration p) {
          setState(() => _position = p);
        });
      } catch (e) {
        print('Error setting audio source: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l’initialisation de la lecture : $e')),
        );
      }
    } else {
      print('Audio URL (fileUrl) is missing or empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune URL audio disponible')),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      if (widget.music.fileUrl != null && widget.music.fileUrl!.isNotEmpty) {
        try {
          _audioPlayer.play(UrlSource(widget.music.fileUrl!));
        } catch (e) {
          print('Error playing audio: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de la lecture : $e')),
          );
        }
      } else {
        print('Audio URL (fileUrl) is missing or empty');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucune URL audio disponible')),
        );
      }
    }
    setState(() => _isPlaying = !_isPlaying);
  }

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
                    widget.music.coverImageUrl,
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, size: 150, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Text(widget.music.title, style: const TextStyle(color: Colors.white, fontSize: 24)),
                Text(widget.music.artist, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                const SizedBox(height: 30),
                // Contrôles de lecture
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.volume_up, color: Colors.white),
                      onPressed: () {}, // À implémenter selon vos besoins
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      onPressed: () {}, // À implémenter
                    ),
                    IconButton(
                      icon: const Icon(Icons.shuffle_rounded, color: Colors.white),
                      onPressed: () {}, // À implémenter
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat, color: Colors.white),
                      onPressed: () {}, // À implémenter
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border_outlined, color: Colors.white),
                      onPressed: () async {
                        try {
                          await _apiService.likeMusic(widget.music.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Musique likée !')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erreur lors du like : $e')),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Barre de progression
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(_position.toString().split('.').first, style: TextStyle(color: Colors.grey)),
                      Expanded(
                        child: Slider(
                          value: _position.inSeconds.toDouble(),
                          min: 0,
                          max: _duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              _audioPlayer.seek(Duration(seconds: value.toInt()));
                            });
                          },
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                        ),
                      ),
                      Text(_duration.toString().split('.').first, style: TextStyle(color: Colors.grey)),
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
                        onPressed: () {}, // À implémenter
                      ),
                      IconButton(
                        iconSize: 65,
                        icon: _isPlaying ? const Icon(Icons.pause, color: Colors.white) : const Icon(Icons.play_arrow, color: Colors.white),
                        onPressed: _playPause,
                      ),
                      IconButton(
                        iconSize: 65,
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: () {}, // À implémenter
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