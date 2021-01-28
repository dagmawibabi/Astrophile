import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageViewPage extends StatefulWidget {
  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    Map receivedData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "ASTROPHILE",
          style: TextStyle(
            fontFamily: "Aladin",
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 100.0,
          child: Center(
            child: Hero(
              tag: receivedData["heroTag"],
              child: CachedNetworkImage(
                  imageUrl: receivedData["data"]["hdurl"],
                  placeholder: (context, url) => SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightGreenAccent,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.pink),
                          strokeWidth: 2.0,
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download_outlined),
        backgroundColor: Colors.grey[900],
        onPressed: () async {
          try {
            var imageId = await ImageDownloader.downloadImage(
                receivedData["data"]["hdurl"]);
            if (imageId == null) {
              return SnackBar(content: Text("Download Failed"));
            }
          } catch (e) {
            return SnackBar(content: Text("Download Failed"));
          }
        },
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
              onPressed: () async {
                List<String> curListOfDates;
                List<String> curListOfTitles;
                List<String> curListOfImages;
                /*curListOfDates.add("RUTH2");
                curListOfTitles.add("RUTH2");
                curListOfImages.add("RUTH2");*/
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (prefs.getStringList("favDateList") != null) {
                  curListOfDates = prefs.getStringList("favDateList");
                } else {
                  curListOfDates = [];
                }
                if (prefs.getStringList("favTitleList") != null) {
                  curListOfTitles = prefs.getStringList("favTitleList");
                } else {
                  curListOfTitles = [];
                }
                if (prefs.getStringList("favImageList") != null) {
                  curListOfImages = prefs.getStringList("favImageList");
                } else {
                  curListOfImages = [];
                }
                curListOfDates.add(receivedData["data"]["date"]);
                curListOfTitles.add(receivedData["data"]["title"]);
                curListOfImages.add(receivedData["data"]["url"]);

                prefs.setStringList("favDateList", curListOfDates);
                prefs.setStringList("favTitleList", curListOfTitles);
                prefs.setStringList("favImageList", curListOfImages);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
