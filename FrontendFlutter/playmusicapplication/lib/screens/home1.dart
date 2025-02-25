import 'package:flutter/material.dart';
import 'package:playmusicapplication/models/music_mod.dart';
import 'package:playmusicapplication/widgets/music_card.dart';
import 'package:playmusicapplication/screens/list_music.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Music> topLike = [
    Music(
        title: "The Wave",
        artist: "Top Like",
        coverUrl: "assets/images/gojo.jpeg",
        streams: 5000000),
    Music(
        title: "Hello Davis",
        artist: "Top Like",
        coverUrl: "assets/images/gojo.jpeg",
        streams: 3000000),
    Music(
        title: "Bye Bye",
        artist: "Top Like",
        coverUrl: "assets/images/gojo.jpeg",
        streams: 3000000),
  ];

  final List<Music> recentlyPlayed = [
    Music(
        title: "Never",
        artist: "Heart - VEVO",
        coverUrl: "assets/images/gojo.jpeg",
        streams: 1000000),
    Music(
        title: "Jack In The Box",
        artist: "JHope - 2022",
        coverUrl: "assets/images/gojo.jpeg",
        streams: 800000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 39, 56), // 🔵 Fond bleu sombre
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MusicListScreen();
            }));
          },
        ),
        title: Row(
          children: [
            Image.asset("assets/images/jj.jpg", height: 30),
            SizedBox(width: 10),
            Text(
              "Music Player",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ **Carte principale sous l'AppBar**
           Container(
  padding: EdgeInsets.all(20),
  height: 150,
  decoration: BoxDecoration(
    color: Color(0xFF1B263B), // Bleu plus clair
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 10,
        offset: Offset(2, 4),
      ),
    ],
    image: DecorationImage(
      image: AssetImage("assets/images/jj.jpg"),
      fit: BoxFit.cover,
    ),
  ),
  child: Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 80,
          height: 80,
          color: Colors.black.withOpacity(0.5), // Ajoute une légère opacité à l'image pour améliorer la lisibilité
          child: Center(
            child: Icon(
              Icons.music_note,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      SizedBox(width: 15, height: 25),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Top Hits",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("Best music for you!",
              style: TextStyle(color: Colors.white70)),
        ],
      ),
    ],
  ),
),

            SizedBox(height: 20),

            // ✅ **Top Like**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Top Like",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text("See all", style: TextStyle(color: Colors.blueAccent)),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 180, // Fixe la hauteur du carrousel

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topLike.length,
                itemBuilder: (context, index) =>
                    MusicCard(music: topLike[index]),
              ),
            ),

            SizedBox(height: 20),

            // ✅ **Recently Played**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recently Played",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text("See all", style: TextStyle(color: Colors.blueAccent)),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recentlyPlayed.length,
                itemBuilder: (context, index) {
                  final music = recentlyPlayed[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFF1B263B),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(2, 3),
                        )
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(music.coverUrl,
                            width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      title: Text(music.title,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(music.artist,
                          style: TextStyle(color: Colors.white70)),
                      trailing: Icon(Icons.more_vert, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
