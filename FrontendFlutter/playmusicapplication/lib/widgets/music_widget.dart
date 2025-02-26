import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:playmusicapplication/service/api_service.dart';

class MusicUploadWidget extends StatefulWidget {
  final VoidCallback onUploadComplete;

  const MusicUploadWidget({required this.onUploadComplete, super.key});

  @override
  State<MusicUploadWidget> createState() => _MusicUploadWidgetState();
}

class _MusicUploadWidgetState extends State<MusicUploadWidget> {
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _albumController = TextEditingController();
  final _genreController = TextEditingController();
  // final _releaseDateController = TextEditingController();

  Uint8List? _audioBytes;
  Uint8List? _coverBytes;
  String? _audioFileName;
  String? _coverFileName;

  bool _isUploading = false;
  String? _uploadStatus;

  Future<void> _uploadMusic() async {
    if (_audioBytes != null && _coverBytes != null) {
      setState(() {
        _isUploading = true;
        _uploadStatus = null;
      });

      try {
        await ApiService().uploadMusic(
          title: _titleController.text,
          artist: _artistController.text,
          album: _albumController.text,
          genre: _genreController.text,
          // releaseDate: _releaseDateController.text,
          audioBytes: _audioBytes!,
          coverBytes: _coverBytes!,
        );

        setState(() {
          _uploadStatus = "✅ Upload réussi !";
        });

        widget.onUploadComplete();
      } catch (e) {
        setState(() {
          _uploadStatus = "❌ Échec de l'upload : ${e.toString()}";
        });
      }

      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upload Music",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Title
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),

          // Artist
          TextField(
            controller: _artistController,
            decoration: const InputDecoration(labelText: 'Artist'),
          ),
          const SizedBox(height: 10),

          // Album
          TextField(
            controller: _albumController,
            decoration: const InputDecoration(labelText: 'Album'),
          ),
          const SizedBox(height: 10),

          // Genre
          TextField(
            controller: _genreController,
            decoration: const InputDecoration(labelText: 'Genre'),
          ),
          const SizedBox(height: 10),

          // Release Date
          // TextField(
          //   controller: _releaseDateController,
          //   decoration: const InputDecoration(labelText: 'Release Date (YYYY-MM-DD)'),
          // ),
          // const SizedBox(height: 20),

          // Select Audio File
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
              if (result != null) {
                setState(() {
                  _audioBytes = result.files.single.bytes;
                  _audioFileName = result.files.single.name;
                });
              }
            },
            child: const Text('Select Audio File'),
          ),
          if (_audioFileName != null)
            Text("🎵 Selected: $_audioFileName", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 10),

          // Select Cover Image
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
              if (result != null) {
                setState(() {
                  _coverBytes = result.files.single.bytes;
                  _coverFileName = result.files.single.name;
                });
              }
            },
            child: const Text('Select Cover Image'),
          ),
          if (_coverFileName != null)
            Text("🖼 Selected: $_coverFileName", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 20),

          // Upload Button
          ElevatedButton(
            onPressed: (_audioBytes == null || _coverBytes == null || _isUploading)
                ? null
                : _uploadMusic,
            child: _isUploading ? const CircularProgressIndicator() : const Text('Upload'),
          ),
          
          if (_uploadStatus != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _uploadStatus!,
                style: TextStyle(
                  color: _uploadStatus!.contains("✅") ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
