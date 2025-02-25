// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';

// class FilePickerWidget extends StatelessWidget {
//   final String label;
//   final bool isAudio; // Indiquer si c'est un fichier audio ou une image
//   final Function(File) onFilePicked;

//   const FilePickerWidget({
//     required this.label,
//     required this.isAudio,
//     required this.onFilePicked,
//   });

//   Future<void> _pickFile(BuildContext context) async {
//     if (isAudio) {
//       // Utilisation de file_picker pour sélectionner un fichier audio
//       FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
//       if (result != null) {
//         onFilePicked(File(result.files.single.path!));
//       }
//     } else {
//       // Utilisation de image_picker pour sélectionner une image
//       final _picker = ImagePicker();
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         onFilePicked(File(pickedFile.path));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => _pickFile(context),
//       child: Text(label),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_model.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({Key? key, required this.artist}) : super(key: key);

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
            Text(artist.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(artist.country, style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 41, 87, 110))),
            const SizedBox(height: 16),
            const Text('Top Mix', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ...artist.topMix.map((song) => ListTile(
              title: Text(song.title, style: const TextStyle(color: Colors.white)),
              subtitle: Text(song.artist, style: TextStyle(color: Colors.blueGrey[300])),
            )).toList(),
            const SizedBox(height: 16),
            const Text('Recently Played', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ...artist.recentlyPlayed.map((song) => ListTile(
              title: Text(song.title, style: const TextStyle(color: Colors.white)),
              subtitle: Text(song.artist, style: TextStyle(color: Colors.blueGrey[300])),
            )).toList(),
          ],
        ),
      ),
    );
  }
}