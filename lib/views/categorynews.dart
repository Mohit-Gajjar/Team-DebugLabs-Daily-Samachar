import 'package:flutter/material.dart';
import 'package:newapp/helper/news.dart';
import 'package:newapp/models/articlemodel.dart';
import 'package:newapp/views/articleview.dart';

class CategoryNews extends StatefulWidget {
  final String category, title;
  
  // ignore: use_key_in_widget_constructors
  const CategoryNews({required this.category, required this.title});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  // ignore: deprecated_member_use
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(widget.title, style:const TextStyle(color: Colors.blue)),
          centerTitle: true,
          elevation: 0,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Column(children: <Widget>[
                        ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: articles.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url,
                              );
                            }),
                      ]),
                    ],
                  ),
                ),
              ));
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  // ignore: use_key_in_widget_constructors
  const BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Column(
        children: [
          ClipRRect(
            child: Image.network(imageUrl),
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(desc),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
