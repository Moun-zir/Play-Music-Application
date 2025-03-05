// import 'package:flutter/material.dart';
// import 'package:playmusicapplication/models/music_mod.dart';
// import 'package:playmusicapplication/widgets/muzic.dart';
// import 'package:playmusicapplication/screens/player.dart';
// import 'package:playmusicapplication/screens/createPlaylist.dart';

// class MusicListScreen extends StatelessWidget {
//   final List<Music> musicList = [
//     Music(
//         title: "Nakhla",
//         artist: "Hidden & Khalse & Sijal",
//         coverUrl: "assets/images/jj.jpg",
//         streams: 3000000),
//     Music(
//         title: "Nakhla",
//         artist: "Hidden & Khalse & Sijal",
//         coverUrl: "assets/images/jj.jpg",
//         streams: 3000000),
//     Music(
//         title: "Nakhla",
//         artist: "Hidden & Khalse & Sijal",
//         coverUrl: "assets/images/gojo.jpeg",
//         streams: 3000000),
//     Music(
//         title: "The Wave",
//         artist: "Top Like",
//         coverUrl: "assets/images/gojo.jpeg",
//         streams: 5000000),
//     Music(
//         title: "Hello Davis",
//         artist: "Top Like",
//         coverUrl: "assets/images/jj.jpg",
//         streams: 3000000),
//     Music(
//         title: "Bye Bye",
//         artist: "Top Like",
//         coverUrl: "assets/images/gojo.jpeg",
//         streams: 3000000),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 17, 33, 58), // Bleu sombre
//       appBar: AppBar(
//         title: Text("Music Player"),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildOptionButton("Titre"),
//                 _buildOptionButton("Artists"),
//                ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CreatePl(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     "Playlist",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue[600], // Optionnel : couleur du bouton
//                   ),
//                 ),
//                 _buildOptionButton("Albums"),
//               ],
//             ),
//           ),
//           // Liste des musiques
//           Expanded(
//             child: ListView.builder(
//               itemCount: musicList.length,
//               itemBuilder: (context, index) {
//                 return MusicCard(
//                   music: musicList[index],
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             MusicPlayerScreen(music: musicList[index]),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// // Méthode pour créer un bouton d'option
//   Widget _buildOptionButton( String text) {
//     return TextButton(
//       onPressed: () {
//         // Action lorsque l'option est cliquée
//         print("$text clicked");
//       },
//       child: Text(
//         text,
//         style: const TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     );
//   }
// }
