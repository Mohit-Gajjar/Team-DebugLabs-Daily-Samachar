import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newapp/models/articlemodel.dart';

class NewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=01fb2a2675404eda985d25c054c2bacb';
    final response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"].toString(),
            author: element["author"].toString(),
            description: element["description"].toString(),
            url: element["url"].toString(),
            urlToImage: element["urlToImage"].toString(),
            content: element["content"].toString(),
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=01fb2a2675404eda985d25c054c2bacb';
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"].toString(),
            author: element["author"].toString(),
            description: element["description"].toString(),
            url: element["url"].toString(),
            urlToImage: element["urlToImage"].toString(),
            content: element["context"].toString(),
          );
          news.add(articleModel);
        }
      });
    }
  }
}
