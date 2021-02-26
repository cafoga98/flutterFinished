import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_project/Models/model_newsApi.dart';

class ItemList extends StatefulWidget {

  final Articles SnapshotData;

  ItemList({Key key, @required this.SnapshotData});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  bool PressHeart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344,
      height: MediaQuery.of(context).size.height/1.72,
      margin: EdgeInsets.only(
          top: 15,
        right: 15,
        left: 15
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius:2,
                color: Colors.black12
            )
          ]
      ),

      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                  image: widget.SnapshotData.UrlToImage != null ?  NetworkImage(widget.SnapshotData.UrlToImage) : AssetImage('assets/img/backbit.png'))
            ),
          ),

          Flexible(
              child: Container(
                padding: EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.SnapshotData.Title ?? 'Title not find',
                        maxLines: 3,
                        style: GoogleFonts.signika(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                        )),

                    Text(widget.SnapshotData.Author ?? 'Author not find',
                        style: GoogleFonts.signika(
                            fontSize: 14,
                            color: Colors.black45,
                            fontWeight: FontWeight.normal
                        )),

                    Container(
                      height: 10,
                    ),

                    Text(widget.SnapshotData.Description ?? 'Description not find',
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                        maxLines: 4,
                        style: GoogleFonts.signika(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal
                        ))
                  ],
                ),
              )),

          Container(
            margin: EdgeInsets.only(
                right: 13,
                left: 3
            ),
            child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: PressHeart != true ? Icon(Ionicons.heart_outline) : Icon(Ionicons.heart),
                        onPressed: (){
                          setState(() {
                            PressHeart = !PressHeart;
                            _saveFavoriteList(SnapshotReceive: widget.SnapshotData);
                          });
                        }
                    ),

                    InkWell(
                      child: Text("MORE",
                          style: GoogleFonts.signika(
                              fontSize: 14,
                              color: Color(0xFF347CFF),
                              fontWeight: FontWeight.normal
                          )),
                      onTap: () => Navigator.pushNamed(context, '/preview', arguments: widget.SnapshotData),
                    ),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

  _saveFavoriteList({@required Articles SnapshotReceive}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> FavoriteList = prefs.getStringList('FavoriteList') ?? [];

    FavoriteList.add(json.encode(SnapshotReceive.toJson()));

    await prefs.setStringList('FavoriteList', FavoriteList);
  }
}
