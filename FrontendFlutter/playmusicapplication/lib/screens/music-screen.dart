import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music-model.dart';
import 'package:playmusicapplication/service/api_service.dart';
import 'package:playmusicapplication/widgets/music_widget.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late Future<List<Music>> _musicList;

  @override
  void initState() {
    super.initState();
    _fetchMusic();
  }

  void _fetchMusic() {
    setState(() {
      _musicList = ApiService().getMusicList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Music')),
      body: Column(
        children: [
          MusicUploadWidget(onUploadComplete: _fetchMusic),
          Expanded(
            child: FutureBuilder<List<Music>>(
              future: _musicList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final music = snapshot.data![index];
                      return ListTile(
                        title: Text(music.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(music.artist),
                            Text('Album: ${music.album}'),
                            Text('Genre: ${music.genre}'),
                          ],
                        ),
                        leading: music.coverImageUrl.isNotEmpty
                            ? Image.network(music.coverImageUrl)
                            : null,
                        trailing: IconButton(
                          icon: Text('❤️ ${music.likes}'),
                          onPressed: () async {
                            await ApiService().likeMusic(music.id);
                            _fetchMusic();
                          },
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No data available'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
