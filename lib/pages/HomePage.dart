import 'package:astrophile/pages/FavoritesDismissibleCards.dart';
import 'package:astrophile/pages/FetchData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  bool initialState = true;
  Map receivedData;
  DateTime chosenDate;
  List instancesToDisplay = [];
  void getAPOTD(String date) async {
    FetchData instance = FetchData();
    await instance.getAPOTD(date);
    Map searchedData = instance.instanceData;
    if (instance.instanceData["media_type"] == "image") {
      instancesToDisplay.add(searchedData);
    }
    setState(() {});
  }

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

  void openFavs(index) {
    setState(() {
      getAPOTD(favDateList[index].toString().substring(0, 10));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void deleteFavs(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    receivedData = ModalRoute.of(context).settings.arguments;
    initialState == true
        ? instancesToDisplay.add(receivedData["instanceData"])
        : initialState = false;
    initialState = false;
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
      body: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: instancesToDisplay.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                color: index == 0 ? Colors.grey[300] : Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //  TODAY/YOUR-PICK AND DATE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: index == 0 ? Colors.black : Colors.white,
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 2.0),
                              child: Text(
                                index == 0 ? "TODAY" : "YOUR PICK",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: index == 0
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            instancesToDisplay[index]["date"],
                            style: TextStyle(
                                fontSize: 16.0,
                                color:
                                    index == 0 ? Colors.black : Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                      // APOTD
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "imageView",
                            arguments: {
                              "data": instancesToDisplay[index],
                              "heroTag": index.toString(),
                            },
                          );
                        },
                        child: Hero(
                          tag: index.toString(),
                          child: CachedNetworkImage(
                              imageUrl: instancesToDisplay[index]["url"],
                              placeholder: (context, url) => Column(
                                    children: [
                                      SizedBox(height: 100.0),
                                      SizedBox(
                                        height: 50.0,
                                        width: 50.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          backgroundColor:
                                              Colors.lightGreenAccent,
                                          valueColor:
                                              new AlwaysStoppedAnimation(
                                                  Colors.pink),
                                        ),
                                      ),
                                      SizedBox(height: 100.0),
                                    ],
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error)),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // TITLE AND EXPLANATION
                      Column(
                        children: [
                          Text(
                            "Title: \"" +
                                instancesToDisplay[index]["title"] +
                                "\"",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: index == 0 ? Colors.black : Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            color: Colors.grey[500],
                            child: ExpansionTile(
                              leading: Icon(
                                Icons.library_books,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Explanation",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      instancesToDisplay[index]["explanation"],
                                      style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 17.0,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              index + 1 == instancesToDisplay.length
                  ? SizedBox(height: 150.0)
                  : SizedBox(height: 4.0),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[900],
        child: Icon(Icons.calendar_today),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: chosenDate == null ? DateTime.now() : chosenDate,
            firstDate: DateTime(1996),
            lastDate: DateTime.now(),
          ).then(
            (date) {
              chosenDate = date;
              if (date == DateTime.now()) {
                _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              } else {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              }
              getAPOTD(date.toString().substring(0, 10));
            },
          );
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
              onPressed: () {
                initiateSP();
                showModalBottomSheet(
                  backgroundColor: Colors.grey[900],
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        // FAVORITES TITLE
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              Text(
                                "FAVORITES",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: "Aladin",
                                ),
                              ),
                              Divider(
                                thickness: 1.4,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        // FAVS
                        Expanded(
                          child: Container(
                            color: Colors.grey[700],
                            child: favDateList != null
                                ? ListView.builder(
                                    itemCount: favDateList.length,
                                    itemBuilder: (context, index) {
                                      // FAVORITES DISMISSIBLE CARDS
                                      try {
                                        return Column(
                                          children: [
                                            FavoritesDismissibleCards(
                                                index: index,
                                                getAPOTD: getAPOTD,
                                                favDateList: favDateList,
                                                favTitleList: favTitleList,
                                                favImageList: favImageList,
                                                openFavorite: openFavs,
                                                deleteFavorite: deleteFavs,
                                                scrollController:
                                                    _scrollController),
                                            index == favDateList.length - 1
                                                ? SizedBox(height: 100.0)
                                                : SizedBox(height: 0.0)
                                          ],
                                        );
                                      } catch (e) {
                                        return Center(
                                          child: Text(e.toString()),
                                        );
                                      }
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
                          ),
                        ),
                        // CLEAR ALL FAVS BUTTON
                        Column(
                          children: [
                            Divider(
                              thickness: 2.0,
                              color: Colors.white,
                            ),
                            RaisedButton(
                              child: Text("Clear All Favs"),
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(height: 8.0),
                          ],
                        )
                      ],
                    );
                    // DISPLAY WHEN THERE ARE NO FAVS
                  },
                );
              },
            ),
            SizedBox(width: 10.0),
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.list_alt,
                size: 28.0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "editorsPicks");
              },
            ),
          ],
        ),
      ),
    );
  }
}
