import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newapp/helper/data.dart';
import 'package:newapp/helper/news.dart';
import 'package:newapp/models/articlemodel.dart';
import 'package:newapp/models/categorymodel.dart';
import 'package:newapp/views/aboutus.dart';
import 'package:newapp/views/articleview.dart';
import 'package:newapp/views/categorynews.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    NewsClass newsClass = NewsClass();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs())),
                icon: const Icon(Icons.info_outline_rounded))
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Daily', style: TextStyle(color: Colors.black)),
              Text('Samachar', style: TextStyle(color: Colors.blue))
            ],
          ),
          elevation: 0,
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl!,
                                categoryItem: categories[index].categoryName!,
                              );
                            }),
                      ),
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

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryItem;
  const CategoryTile(
      {Key? key, required this.imageUrl, required this.categoryItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryItem.toLowerCase(),
                      title: categoryItem,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(children: [
          ClipRRect(
            child: CachedNetworkImage(
                imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(6),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryItem,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ]),
      ),
    );
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
