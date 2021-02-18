import 'dart:async';
import 'dart:convert';

import 'package:cpe_flutter/screens/fragments/pagination/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_news_web/model/news.dart';
// import 'package:flutter_news_web/news_details.dart';
import 'package:http/http.dart' as http;

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  Future<List<Article>> getData(String newsType) async {
    List<Article> list;
    // String link = "https://newsapi.org/v2/top-headlines?country=in&apiKey=API_KEY";
    String link = "https://newsapi.org/v2/top-headlines?country=in&apiKey=d1df415b18df494387db62e9f7164cb5";
    var res = await http.get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      print(rest);
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Widget listViewWidget(List<Article> article) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  '${article[position].title}',
                  style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                /*leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: article[position].urlToImage == null
                        ? Image(
                            image: AssetImage('images/no_image_available.png'),
                          )
                        : Image.network('${article[position].urlToImage}'),
                    height: 100.0,
                    width: 100.0,
                  ),
                ),*/
                onTap: () => _onTapItem(context, article[position]),
              ),
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, Article article) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NewsDetails(article, widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          // widget.title,
          'Test Title',
        ),
      ),
      body: FutureBuilder(
          // future: getData(widget.newsType),
          future: getData(''),
          builder: (context, snapshot) {
            return snapshot.data != null ? listViewWidget(snapshot.data) : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
