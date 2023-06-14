import 'package:flutter/material.dart';
import '../models/news_models.dart';
import '../screens/news_details.dart';

class NewsTile extends StatelessWidget {
  final ArticleModel article;

  const NewsTile({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailPage(article:article);
        }));
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    article.urlToImage,
                    height: 70,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                height: 12,
                width: 23,
              ),
              Flexible(
                flex: 1,
                child: Text(
                  article.title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Color.fromARGB(221, 89, 85, 80),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          )),
    );
  }
}
