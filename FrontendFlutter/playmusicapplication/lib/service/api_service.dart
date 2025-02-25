import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://localhost:8080/api/music/upload"; // Remplacez par l'URL de votre API

  Future<bool> uploadMusic(File musicFile, File coverImageFile, String userId) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Ajouter le fichier de musique
    var musicFileStream = http.MultipartFile('musicFile', musicFile.readAsBytes().asStream(), musicFile.lengthSync(),
        filename: musicFile.path.split('/').last);
    request.files.add(musicFileStream);

    // Ajouter l'image de couverture
    var coverImageStream = http.MultipartFile('coverImageFile', coverImageFile.readAsBytes().asStream(), coverImageFile.lengthSync(),
        filename: coverImageFile.path.split('/').last);
    request.files.add(coverImageStream);

    // Ajouter l'ID de l'utilisateur
    request.fields['userId'] = userId;

    // Envoyer la requête
    var response = await request.send();

    if (response.statusCode == 200) {
      return true; // Succès
    } else {
      return false; // Échec
    }
  }
}
