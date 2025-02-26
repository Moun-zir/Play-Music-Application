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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upload Music",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          _buildTextField(_titleController, 'Title'),
          const SizedBox(height: 15),

          // Artist
          _buildTextField(_artistController, 'Artist'),
          const SizedBox(height: 15),

          // Album
          _buildTextField(_albumController, 'Album'),
          const SizedBox(height: 15),

          // Genre
          _buildTextField(_genreController, 'Genre'),
          const SizedBox(height: 20),

          // Select Audio File
          _buildFilePickerButton('Select Audio File', _audioFileName, () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
            if (result != null) {
              setState(() {
                _audioBytes = result.files.single.bytes;
                _audioFileName = result.files.single.name;
              });
            }
          }),
          const SizedBox(height: 10),

          // Select Cover Image
          _buildFilePickerButton('Select Cover Image', _coverFileName, () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null) {
              setState(() {
                _coverBytes = result.files.single.bytes;
                _coverFileName = result.files.single.name;
              });
            }
          }),
          const SizedBox(height: 20),

          // Upload Button
          _buildUploadButton(),
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _buildFilePickerButton(String label, String? fileName, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(fileName != null ? Icons.check_circle : Icons.upload_file),
          const SizedBox(width: 10),
          Text(fileName != null ? 'Selected: $fileName' : label),
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: (_audioBytes == null || _coverBytes == null || _isUploading)
          ? null
          : _uploadMusic,
      child: _isUploading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Upload'),
    );
  }
}
