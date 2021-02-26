import 'package:flutter/material.dart';
import 'package:my_first_project/Models/model_newsApi.dart';
import 'package:my_first_project/Presenter/build_itemList.dart';
import 'package:my_first_project/Utils/Widget/item_list.dart';
import 'package:my_first_project/Utils/apiService.dart';
import 'package:my_first_project/Utils/Widget/errorPage.dart';

import '../Utils/Persisters.dart' as globals;


class BuildView extends StatelessWidget {

  final String viewName;
  int NewsInt;

  BuildView({Key key, @required this.viewName, @required this.NewsInt});

  @override
  Widget build(BuildContext context) {

    switch(viewName){
      case "NewsList":
        return Container(
            child: Center(
              child: Container(
                  child: FutureBuilder(
                    future: ApiService().GetDio(OptionUrl: NewsInt),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: (snapshot.data).ArticlesList.length,
                          itemBuilder: (BuildContext context, int index){
                            return BuildItemList(SnapshotData: (snapshot.data).ArticlesList[index]);
                          },
                        );
                      }else if(snapshot.hasError){
                        this.onGetDescargosError(snapshot.error.toString());
                        return ErrorPage();
                      }
                      return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: 500,
                            child: Center(
                                child: CircularProgressIndicator()
                            ),
                          )
                      );
                    },

                  )
              ),
            )
        );
      case "FavoriteList":
        return Container(
            child: Center(
              child: Container(
                  child: FutureBuilder(
                    future: ApiService().GetJsonSh(),
                    builder: (context, snapshot){
                      if(snapshot.hasData || snapshot.data.length != 0){
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return BuildItemList(SnapshotData: snapshot.data[index]);
                          },
                        );
                      }else if(snapshot.hasError){
                        this.onGetDescargosError(snapshot.error.toString());
                        return ErrorPage();
                      }
                      return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: 500,
                            child: Center(
                                child: CircularProgressIndicator()
                            ),
                          )
                      );
                    },

                  )
              ),
            )
        );;
    }
  }

  void onGetDescargosError(String string) {}
}
