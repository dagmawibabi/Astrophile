import 'package:flutter/material.dart';

class EditorsPicks extends StatefulWidget {
  @override
  _EditorsPicksState createState() => _EditorsPicksState();
}

class _EditorsPicksState extends State<EditorsPicks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "EDITOR'S PICKS",
          style: TextStyle(
            fontFamily: "Aladin",
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[900],
        child: Icon(Icons.calendar_today),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.grey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.favorite_outline,
                size: 28.0,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10.0),
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.list_alt,
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
