import 'package:flutter/material.dart';

class PlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Playlist'),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PlaylistTile(
                title: 'Study playlist',
                songsCount: 379,
                imagePath: 'assets/images/gojo.jpeg',
              ),
              PlaylistTile(
                title: 'Sleep playlist',
                songsCount: 219,
                imagePath: 'assets/images/jj.jpg',
              ),
              PlaylistTile(
                title: 'Sleep playlist',
                songsCount: 219,
                imagePath: 'assets/images/gojo.jpeg',
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pause_circle_filled),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
          ],
          backgroundColor: Colors.deepPurple,
          unselectedItemColor: Colors.white70,
          selectedItemColor: Colors.white,
        ),
      ),
    );
  }
}

class PlaylistTile extends StatelessWidget {
  final String title;
  final int songsCount;
  final String imagePath;

  PlaylistTile({required this.title, required this.songsCount, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Playlist Image
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 16),
              // Playlist Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$songsCount songs',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('add playlist'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        disabledBackgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
