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
    // Thème de couleurs basé sur le bleu sombre et ses variantes
    const Color primaryDarkBlue = Color(0xFF1A2A3A); // Bleu nuit profond
    const Color secondaryDarkBlue = Color(0xFF2C3E50); // Bleu foncé
    const Color accentBlue = Color(0xFF3498DB); // Bleu clair pour les accents
    const Color textLight = Colors.white; // Texte clair pour contraste
    const Color greyHint = Colors.grey; // Texte gris pour les hints

    return Scaffold(
      backgroundColor: primaryDarkBlue, // Fond bleu nuit
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre du formulaire avec animation de fade
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: const Text(
                "Upload Your Music",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textLight,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card contenant le formulaire pour un effet moderne
            Card(
              elevation: 8,
              color: secondaryDarkBlue, // Fond bleu foncé pour le card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Champ Title
                    _buildTextField(
                      controller: _titleController,
                      label: 'Title',
                      icon: Icons.music_note,
                      color: accentBlue,
                    ),
                    const SizedBox(height: 16),

                    // Champ Artist
                    _buildTextField(
                      controller: _artistController,
                      label: 'Artist',
                      icon: Icons.person,
                      color: accentBlue,
                    ),
                    const SizedBox(height: 16),

                    // Champ Album
                    _buildTextField(
                      controller: _albumController,
                      label: 'Album',
                      icon: Icons.album,
                      color: accentBlue,
                    ),
                    const SizedBox(height: 16),

                    // Champ Genre
                    _buildTextField(
                      controller: _genreController,
                      label: 'Genre',
                      icon: Icons.category,
                      color: accentBlue,
                    ),
                    const SizedBox(height: 24),

                    // Sélection du fichier audio avec bouton stylisé
                    _buildFileButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
                        if (result != null) {
                          setState(() {
                            _audioBytes = result.files.single.bytes;
                            _audioFileName = result.files.single.name;
                          });
                        }
                      },
                      label: 'Select Audio File',
                      icon: Icons.audio_file,
                      selectedFileName: _audioFileName,
                    ),
                    const SizedBox(height: 16),

                    // Sélection de l'image de couverture avec bouton stylisé
                    _buildFileButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                        if (result != null) {
                          setState(() {
                            _coverBytes = result.files.single.bytes;
                            _coverFileName = result.files.single.name;
                          });
                        }
                      },
                      label: 'Select Cover Image',
                      icon: Icons.image,
                      selectedFileName: _coverFileName,
                    ),
                    const SizedBox(height: 24),

                    // Bouton d'upload avec animation
                    AnimatedButton(
                      isLoading: _isUploading,
                      onPressed: (_audioBytes == null || _coverBytes == null || _isUploading)
                          ? null
                          : _uploadMusic,
                      child: const Text(
                        'Upload Music',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textLight),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Statut d'upload
            if (_uploadStatus != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    _uploadStatus!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _uploadStatus!.contains("✅") ? Colors.lightGreenAccent : Colors.redAccent,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget pour les champs de texte stylisés
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: color),
        filled: true,
        fillColor: Colors.blueGrey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: 2),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  // Widget pour les boutons de sélection de fichiers
  Widget _buildFileButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
    required String? selectedFileName,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Widget personnalisé pour le bouton d'upload avec animation
class AnimatedButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget child;

  const AnimatedButton({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    if (widget.isLoading) _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryDarkBlue = Color(0xFF1A2A3A);
    const Color accentBlue = Color(0xFF3498DB);

    return ScaleTransition(
      scale: _animation,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          disabledBackgroundColor: Colors.blueGrey[600],
          disabledForegroundColor: Colors.white70,
        ),
        child: widget.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : widget.child,
      ),
    );
  }
}