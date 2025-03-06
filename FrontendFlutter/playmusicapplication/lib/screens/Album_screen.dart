import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Album Title'),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Album Cover
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/jj.jpg'), // Remplacez par votre image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Album Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ALBUM TITLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '10 Songs',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '15M followers',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // List of Songs
              ...List.generate(6, (index) => SongTile(index + 1)),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  final int index;

  SongTile(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.play_arrow, color: Colors.white),
          title: Text(
            'Artist - Song Title 0$index',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '4:10 • Explicit',
            style: TextStyle(color: Colors.white70),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_border, color: Colors.white70),
              SizedBox(width: 16),
              Icon(Icons.more_vert, color: Colors.white70),
            ],
          ),
        ),
        // Divider Line
        Divider(
          color: Colors.deepPurple,
          thickness: 1,
        ),
      ],
    );
  }
}
