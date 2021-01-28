import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favDateList;
  List<String> favTitleList;
  List<String> favImageList;
  void initiateSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favDateList = prefs.getStringList("favDateList");
    favTitleList = prefs.getStringList("favTitleList");
    favImageList = prefs.getStringList("favImageList");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initiateSP();
  }

  @override
  Widget build(BuildContext context) {
    initiateSP();
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "FAVORITES",
          style: TextStyle(
            fontFamily: "Aladin",
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: favDateList != null
          ? ListView.builder(
              itemCount: favDateList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 2.0),
                  child: Dismissible(
                    key: Key(favDateList[index].toString()),
                    onDismissed: (direction) async {
                      print(direction);
                      // DELETE FAVORITE
                      if (direction == DismissDirection.endToStart) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        favDateList.removeAt(index);
                        favTitleList.removeAt(index);
                        favImageList.removeAt(index);
                        List<String> newDateList = favDateList;
                        List<String> newTitleList = favTitleList;
                        List<String> newImageList = favImageList;
                        prefs.setStringList("favDateList", newDateList);
                        prefs.setStringList("favTitleList", newTitleList);
                        prefs.setStringList("favImageList", newImageList);
                        setState(() {});
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 6.0),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(favImageList[index]),
                                  radius: 20.0,
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  width: 140.0,
                                  child: Text(
                                    favTitleList[index],
                                    style: TextStyle(fontSize: 14.0),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(favDateList[index]),
                          ),
                        ],
                      ),
                    ),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Icon(
                          Icons.open_in_new,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "You have no favorites!",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[200],
                  fontFamily: "Aladin",
                  letterSpacing: 1.5,
                  wordSpacing: 1.5,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_forever_outlined),
        backgroundColor: Colors.grey[900],
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.grey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            /*IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.favorite_outline,
                size: 28.0,
              ),
              onPressed: () {},
            ),*/
          ],
        ),
      ),
    );
  }
}
