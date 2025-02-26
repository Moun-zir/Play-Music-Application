// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';


import 'package:playmusicapplication/models/music-model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/music';

  Future<List<Music>> getMusicList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((m) => Music.fromJson(m))
          .toList();
    }
    throw Exception('Failed to load music');
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

  request.fields['musicDTO'] = jsonEncode(musicDTO); // Convertir en JSON String

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

  Future<void> createPlaylist(String name, String description) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/playlists'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create playlist');
    }
  }
}
