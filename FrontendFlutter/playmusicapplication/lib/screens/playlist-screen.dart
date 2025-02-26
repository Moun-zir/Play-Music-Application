import 'package:flutter/material.dart';
import 'package:playmusicapplication/service/api_service.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _createPlaylist() async {
    await ApiService().createPlaylist(
      _nameController.text,
      _descriptionController.text,
    );
    _nameController.clear();
    _descriptionController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playlist created')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playlists')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: _createPlaylist,
              child: const Text('Create Playlist'),
            ),
          ],
        ),
      ),
    );
  }
}