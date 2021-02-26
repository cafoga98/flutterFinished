import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_first_project/Models/model_newsApi.dart';
import 'package:my_first_project/Utils/Persisters.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  String UrlForApi(OptionUrl){
    switch (OptionUrl){
    //All articles about Bitcoin from the last month, sorted by recent first
      case 1:
        return 'https://newsapi.org/v2/everything?q=bitcoin&from=2020-12-19&sortBy=publishedAt&apiKey=${globals.TokenNews}';
    //Top business headlines in the US right now
      case 2:
        return 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${globals.TokenNews}';
    //All articles mentioning Apple from yesterday, sorted by popular publishers first
      case 3:
        return 'https://newsapi.org/v2/everything?q=apple&from=2021-01-14&to=2021-01-14&sortBy=popularity&apiKey=${globals.TokenNews}';
    //Top headlines from TechCrunch right now
      case 4:
        return 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${globals.TokenNews}';
    //All articles published by the Wall Street Journal in the last 6 months, sorted by recent first
      case 5:
        return 'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=${globals.TokenNews}';
    }
  }

  GetDio({@required int OptionUrl}) async {
    var dio = Dio();

    Response response = await dio.get(
      UrlForApi(OptionUrl),
    );

    if(response.statusCode == 200){
      print("Todo Salio Bien");

      return NewsApiModel.fromjson(response.data);
    }else{
      print("Opps.. algo salio mal");
    }

  }

  GetJsonSh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> FavoriteList = prefs.getStringList('FavoriteList') ?? [];
    List<Articles> ArticlesListSend = List<Articles>();
    FavoriteList.forEach((element){
      dynamic jsonCONVERT= json.decode(element);
      ArticlesListSend.add(Articles.fromjson(jsonCONVERT));
    });
    return ArticlesListSend;
  }

}