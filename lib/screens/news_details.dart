// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../models/news_models.dart';
import 'news_overview.dart';

class DetailPage extends StatelessWidget {
  final ArticleModel article;

  const DetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 238, 226),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.network(
                article.urlToImage.toString(),
                fit: BoxFit.contain,
                width: double.infinity,
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            article.title.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 78, 78, 78)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.publishedAt.toString(),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 26, 26, 26)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: article.description != null
                              ? Text(
                                  article.description.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 62, 62, 62)),
                                )
                              : const Text(""),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: article.content != null
                              ? Text(
                                  article.content.toString(),
                                  style: const TextStyle(fontSize: 16),
                                )
                              : const Text("Content not available..."),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: (article.content?.length ?? 0) > 0,
                child: Container(
                  height: 55,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return WebViewScreen(
                              articlemodal: article,
                            );
                          },
                        ));
                      },
                      child: const Text(
                        "Read More",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
