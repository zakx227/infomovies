import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  final String title;
  final String date;
  final String lang;
  final String note;
  final String img;

  const CardMovie({
    super.key,
    required this.title,
    required this.date,
    required this.lang,
    required this.note,
    required this.img,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.26,
      decoration: BoxDecoration(
        color: const Color.fromARGB(34, 158, 158, 158),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 100,
              height: MediaQuery.of(context).size.height * 0.25,
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/original/$img',
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        CircularProgressIndicator(color: Colors.white),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text('Date : $date', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Text('Language : $lang', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Note : $note', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10),
                    Icon(Icons.favorite, color: Colors.red, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
