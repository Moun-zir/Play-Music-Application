// lib/services/api_service.dart
import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:playmusicapplication/models/music-model.dart';
import 'package:playmusicapplication/models/playlist-model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/music';

  Future<List<Music>> getMusicList() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:8080/api/music'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((m) => Music.fromJson(m))
          .toList();
    } else {
      throw Exception('Failed to load music, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load music: $e');
  }
}


  Future<void> uploadMusic({
    required String title,
    required String artist,
    required String album,
    required String genre,
    // required String releaseDate,
    required Uint8List audioBytes,
    required Uint8List coverBytes,
  }) async {
    var uri = Uri.parse("http://localhost:8080/api/music/upload");

    var request = http.MultipartRequest("POST", uri);

    // Ajouter le JSON sous forme de String
    Map<String, String> musicDTO = {
      "title": title,
      "artist": artist,
      "album": album,
      "genre": genre,
      // "releaseDate": releaseDate,
    };

    request.fields['musicDTO'] =
        jsonEncode(musicDTO); // Convertir en JSON String

    // Ajouter le fichier audio
    request.files.add(http.MultipartFile.fromBytes(
      'file', // Changer ici pour correspondre au backend
      audioBytes,
      filename: "audio.mp3",
      contentType: MediaType('audio', 'mpeg'),
    ));

    // Ajouter l'image de couverture
    request.files.add(http.MultipartFile.fromBytes(
      'coverImage', // Changer ici pour correspondre au backend
      coverBytes,
      filename: "cover.jpg",
      contentType: MediaType('image', 'jpeg'),
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      print("✅ Upload réussi !");
    } else {
      print("❌ Upload échoué : ${response.statusCode}");
      print(await response.stream.bytesToString()); // Voir l'erreur exacte
    }
  }

  Future<void> likeMusic(int musicId) async {
    final response = await http.post(Uri.parse('$baseUrl/music/$musicId/like'));
    if (response.statusCode != 200) {
      throw Exception('Failed to like music');
    }
  }

  final String apiUrl =
      'http://10.0.2.2:8080/api/playlists'; // Pour l'émulateur Android

  // 📌 Récupérer les playlists d'un utilisateur
  Future<List<Playlist>> fetchUserPlaylists(int userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/playlists/user/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((playlist) => Playlist.fromJson(playlist)).toList();
    } else {
      throw Exception('Failed to load playlists');
    }
  }

  // 📌 Créer une nouvelle playlist avec une image
  Future<void> createPlaylist(
    String name, 
    String description, 
    Uint8List? image, 
    int userId
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    // Créer un DTO pour la playlist
    Map<String, String> playlistDTO = {
      "name": name,
      "description": description,
      "userId": userId.toString(),  // Assurez-vous d'ajouter l'ID utilisateur
    };

    request.fields['playlistDTO'] = jsonEncode(playlistDTO);

    // Ajouter l'image si elle existe
    if (image != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'coverImage', 
        image,  // Utiliser le Uint8List
        filename: "cover.jpg",
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to create playlist');
    }
  }

  // 📌 Supprimer une playlist
  Future<void> deletePlaylist(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete playlist');
    }
  }

  // 📌 Ajouter une musique à une playlist
  Future<void> addMusicToPlaylist(int playlistId, int musicId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/playlists/$playlistId/music/$musicId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add music to playlist');
    }
  }

  // 📌 Supprimer une musique d'une playlist
  Future<void> removeMusicFromPlaylist(int playlistId, int musicId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/playlists/$playlistId/music/$musicId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove music from playlist');
    }
  }
}
