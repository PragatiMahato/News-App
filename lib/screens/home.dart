// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/news_models.dart';
import '../widgets/headllines.dart';
import '../widgets/news_tile.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _loading;
  List newslist = [];

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 238, 226),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("FW",
                  style: TextStyle(
                      color:
                          const Color.fromARGB(255, 31, 87, 83).withOpacity(1),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins')),
              const Text("News",
                  style: TextStyle(
                      color: Color.fromARGB(255, 64, 59, 54),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins')),
            ],
          ),
          actions: [
            IconButton(
            icon: Icon(Icons.logout,color:  Color.fromARGB(255, 31, 87, 83).withOpacity(1),),
           onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
          ),
          ],
        ),
        body: CustomScrollView(slivers: [
          _loading
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, top: 30, bottom: 12),
                    child: const Text(
                      "Top Headliness",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: newslist.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ArticleModel articleModel = newslist[index];
                    return Headlines(
                      article: articleModel,
                    );
                  }),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "More News",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(5),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                ArticleModel articleModel = newslist[index];
                return NewsTile(
                  article: articleModel,
                );
              }, childCount: newslist.length),
            ),
          )
        ]));
  }
  Future<dynamic> Logout() async {

  await FirebaseAuth.instance.signOut();

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}
}
