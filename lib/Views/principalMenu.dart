import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_project/Utils/firebaseController.dart' as firebaseController;
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_first_project/Presenter/build_view.dart';


class NewsApi extends StatefulWidget {

  User user;

  NewsApi(this.user);

  @override
  _NewsApiState createState() => _NewsApiState();
}

class _NewsApiState extends State<NewsApi> {


  String TitleAppBar = 'BIT News';
  int NewsInt = 1;
  String viewName = "NewsList";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black45,),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Ionicons.heart, color: Colors.black87,),
              onPressed: () {
                setState(() {
                  viewName = "FavoriteList";
                  NewsInt = 0;
                  TitleAppBar = "Favorite's List";
                });
              }
          )
        ],
        backgroundColor: Colors.white,
        title: Text(TitleAppBar,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.signika(
                fontSize: 20,
                color: Colors.black45,
                fontWeight: FontWeight.normal
            )),


      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[

              DrawerHeader(
                child: Container(
                  height: MediaQuery.of(context).size.height/12,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/BitLogo.png'),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Text('News', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              ListTile(
                title: Text('All articles about Bitcoin from the last month, sorted by recent first'),
                onTap: () {
                  setState(() {
                    TitleAppBar = 'All articles about Bitcoin from the last month, sorted by recent first';
                    NewsInt = 1;
                    viewName = "NewsList";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Top business headlines in the US right now'),
                onTap: () {
                  setState(() {
                    NewsInt = 2;
                    TitleAppBar = 'Top business headlines in the US right now';
                    viewName = "NewsList";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('All articles mentioning Apple from yesterday, sorted by popular publishers first'),
                onTap: () {
                  setState(() {
                    NewsInt = 3;
                    TitleAppBar ='All articles mentioning Apple from yesterday, sorted by popular publishers first';
                    viewName = "NewsList";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Top headlines from TechCrunch right now'),
                onTap: () {
                  setState(() {
                    NewsInt = 4;
                    TitleAppBar = 'Top headlines from TechCrunch right now';
                    viewName = "NewsList";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('All articles published by the Wall Street Journal in the last 6 months, sorted by recent first'),
                onTap: () {
                  setState(() {
                    NewsInt = 5;
                    TitleAppBar ='All articles published by the Wall Street Journal in the last 6 months, sorted by recent first';
                    viewName = "NewsList";
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: Text('Setting', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              ListTile(
                title: Text('Sign Out'),
                onTap: () {
                  firebaseController.signOut();
                  Navigator.pushNamed(context, '/login');
                },
              ),

            ],
          ),
        ),
      body: BuildView(viewName: viewName, NewsInt: NewsInt)
    );
  }

  void onGetDescargosError(String string) {}

}
