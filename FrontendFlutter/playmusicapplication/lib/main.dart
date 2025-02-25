import 'package:flutter/material.dart';
import 'package:playmusicapplication/screens/home1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Playio',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color.fromARGB(255, 179, 198, 207), // Couleur de fond globale
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 74, 103, 117), // Couleur de l'AppBar
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
    ),
      home: HomeScreen(),
    );
  }
}