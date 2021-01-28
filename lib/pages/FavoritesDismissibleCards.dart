import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesDismissibleCards extends StatefulWidget {
  const FavoritesDismissibleCards({
    Key key,
    @required this.favDateList,
    @required this.favTitleList,
    @required this.favImageList,
    @required ScrollController scrollController,
    @required this.index,
    @required this.getAPOTD,
    @required this.openFavorite,
    @required this.deleteFavorite,
  })  : _scrollController = scrollController,
        super(key: key);
  final int index;
  final Function getAPOTD;
  final Function openFavorite;
  final Function deleteFavorite;
  final List<String> favDateList;
  final List<String> favTitleList;
  final List<String> favImageList;
  final ScrollController _scrollController;

  @override
  _FavoritesDismissibleCardsState createState() =>
      _FavoritesDismissibleCardsState();
}

class _FavoritesDismissibleCardsState extends State<FavoritesDismissibleCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 2.0),
      child: Dismissible(
        key: Key(widget.favDateList[widget.index].toString()),
        // SWIPE TO OPEN AND DELETE FAVS
        onDismissed: (direction) async {
          // DELETE FAVORITE
          if (direction == DismissDirection.endToStart) {
            print(widget.favDateList);
            widget.deleteFavorite(widget.index);
            print(widget.favDateList[widget.index] + " HAS BEEN REMOVED!");
            print(widget.favDateList);
          }
          // OPEN FAVORITE
          else {
            widget.openFavorite(widget.index);
            Navigator.pop(context);
          }
        },
        // FAVORITES
        child: Card(
          color: Colors.grey[900],
          margin: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // FAV-THUMBNAIL AND FAV-TITLE
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    SizedBox(width: 6.0),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.favImageList[widget.index]),
                      radius: 20.0,
                    ),
                    SizedBox(width: 6.0),
                    Container(
                      width: 140.0,
                      child: Text(
                        widget.favTitleList[widget.index],
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    )
                  ],
                ),
              ),
              // FAV-DATE
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  widget.favDateList[widget.index],
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
        // OPEN FAVORITE SWIPE
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
        // DELETE FAVORITE SWIPE
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
  }
}
