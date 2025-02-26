import 'package:flutter/material.dart';
import 'package:playmusicapplication/screens/playlist-screen.dart';
import 'package:playmusicapplication/screens/music-screen.dart';
import 'package:playmusicapplication/screens/list_music.dart';

class MenuDrawer extends StatelessWidget {
  final int userId;

  const MenuDrawer({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
            ),
            child: Image.asset('assets/images/gojo.jpeg'), // Votre image ou logo
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Music'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MusicScreen();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Playlists'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserPlaylistsScreen(userId: userId);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('List Playlists'),
           onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MusicListScreen();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('FAQs'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
