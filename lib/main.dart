import 'package:astrophile/pages/EditorsPicksPage.dart';
import 'package:astrophile/pages/FavoritesPage.dart';
import 'package:astrophile/pages/HomePage.dart';
import 'package:astrophile/pages/ImageViewPage.dart';
import 'package:astrophile/pages/LoadingPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Astrophile",
      initialRoute: "/",
      routes: {
        "/": (context) => LoadingPage(),
        "home": (context) => HomePage(),
        "favorites": (context) => FavoritesPage(),
        "editorsPicks": (context) => EditorsPicks(),
        "imageView": (context) => ImageViewPage(),
      },
    );
  }
}
