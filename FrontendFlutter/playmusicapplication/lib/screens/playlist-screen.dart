import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playmusicapplication/service/api_service.dart';

class UserPlaylistsScreen extends StatefulWidget {
  final int userId;

  UserPlaylistsScreen({required this.userId});

  @override
  _UserPlaylistsScreenState createState() => _UserPlaylistsScreenState();
}

class _UserPlaylistsScreenState extends State<UserPlaylistsScreen> {
  Uint8List? _image;  // Stocke l'image sous forme de bytes

  // Méthode pour choisir une image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Convertir l'image en Uint8List
      setState(() {
        _image = bytes;  // Assigner les bytes à _image
      });
    }
  }

  // Méthode pour afficher le formulaire de création de playlist
  Future<void> _addPlaylist() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Créer une Playlist"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nom')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 10),
            _image != null
                ? Image.memory(_image!, height: 100, width: 100, fit: BoxFit.cover) // Aperçu de l'image
                : Text("Aucune image sélectionnée"),
            TextButton(
              onPressed: _pickImage,
              child: Text("Choisir une image"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () async {
              await ApiService().createPlaylist(
                nameController.text, 
                descriptionController.text, 
                _image, 
                widget.userId,  // Passer l'ID utilisateur
              );
              Navigator.pop(context);
            },
            child: Text("Ajouter"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes Playlists")),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlaylist,
        child: Icon(Icons.add),
      ),
    );
  }
}
