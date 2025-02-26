import 'package:flutter/material.dart';
import 'package:playmusicapplication/service/api_service.dart';
import 'package:playmusicapplication/models/playlist-model.dart';  // Assurez-vous d'importer votre modèle Playlist

class UserPlaylistsScreen extends StatefulWidget {
  final int userId;

  UserPlaylistsScreen({required this.userId});

  @override
  _UserPlaylistsScreenState createState() => _UserPlaylistsScreenState();
}

class _UserPlaylistsScreenState extends State<UserPlaylistsScreen> {
  late Future<List<Playlist>> playlists;  // Changez ici pour Future<List<Playlist>>

  @override
  void initState() {
    super.initState();
    playlists = ApiService().fetchUserPlaylists(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes Playlists')),
      body: FutureBuilder<List<Playlist>>(  // Changez ici aussi
        future: playlists,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('❌ Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune playlist trouvée'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final playlist = snapshot.data![index];
              return ListTile(
                title: Text(playlist.name),
                subtitle: Text(playlist.description.isEmpty ? 'Pas de description' : playlist.description),
                leading: playlist.coverUrl.isNotEmpty
                    ? Image.network(playlist.coverUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : Icon(Icons.music_note),
              );
            },
          );
        },
      ),
    );
  }
}
