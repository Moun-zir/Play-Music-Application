// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:playmusicapplication/service/api_service.dart';

// class UploadMusicScreen extends StatefulWidget {
//   @override
//   _UploadMusicScreenState createState() => _UploadMusicScreenState();
// }

// class _UploadMusicScreenState extends State<UploadMusicScreen> {
//   File? _musicFile;
//   File? _coverImageFile;
//   final _picker = ImagePicker();
//   final ApiService _apiService = ApiService();
//   final _userIdController = TextEditingController();

//   // Sélectionner un fichier audio
//   Future<void> _pickMusicFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);

//     if (result != null) {
//       setState(() {
//         _musicFile = File(result.files.single.path!);
//       });
//     }
//   }

//   // Sélectionner une image de couverture
//   Future<void> _pickCoverImageFile() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _coverImageFile = File(pickedFile.path);
//       });
//     }
//   }

//   // Télécharger la musique
//   Future<void> _uploadMusic() async {
//     if (_musicFile == null || _coverImageFile == null || _userIdController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Veuillez fournir tous les fichiers et l'ID utilisateur")));
//       return;
//     }

//     bool success = await _apiService.uploadMusic(_musicFile!, _coverImageFile!, _userIdController.text);

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Musique téléchargée avec succès")));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Échec du téléchargement")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Télécharger une musique")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _userIdController,
//               decoration: InputDecoration(labelText: "ID Utilisateur"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickMusicFile,
//               child: Text("Choisir un fichier audio"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickCoverImageFile,
//               child: Text("Choisir une image de couverture"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadMusic,
//               child: Text("Télécharger la musique"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_model.dart';
import 'package:playmusicapplication/widgets/fil_picker_widget.dart';

class MusicPlayerScreen extends StatelessWidget {
  final List<Artist> artists = [
    Artist(
      name: 'Luis Fonsi',
      country: 'USB/COUNTRY',
      topMix: [
        Song(title: 'Sexed', artist: 'Luis Fonsi', genre: 'Pop', duration: '3:45'),
        Song(title: 'Culture', artist: 'Luis Fonsi', genre: 'Pop',duration: '3:45'),
        Song(title: 'Business', artist: 'Luis Fonsi', genre: 'Pop', duration: '3:45'),
      ],
      recentlyPlayed: [
        Song(title: 'Never Need Video', artist: 'Luis Fonsi', genre: 'Pop', duration: '3:45'),
        Song(title: 'Alick in The Box', artist: 'Luis Fonsi', genre: 'Pop',duration: '3:45'),
        Song(title: 'Jersey, 2022', artist: 'Luis Fonsi', genre: 'Pop',duration: '3:45'),
      ],
    ),
    Artist(
      name: 'Rautaan Lambiyan',
      country: 'Turkish Report',
      topMix: [],
      recentlyPlayed: [],
    ),
  ];

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playio', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        color: Colors.blueGrey[800], // Couleur de fond de l'écran
        child: ListView(
          children: artists.map((artist) => ArtistCard(artist: artist)).toList(),
        ),
      ),
    );
  }
}
