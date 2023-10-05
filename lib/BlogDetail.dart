// BlogDetailPage.dart

import 'package:flutter/material.dart';

class BlogDetail extends StatefulWidget {
  final String imageUrl;
  final String title;
  //final String sampleText;

  const BlogDetail({super.key,
    required this.imageUrl,
    required this.title,
    //required this.sampleText
  });

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  bool isFavorite = false; // Initially not a favorite

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Detail'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // Toggle the favorite status
              setState(() {
                isFavorite = !isFavorite;
              });

              // Implement code to save or remove the blog as a favorite locally
              if (isFavorite) {
                print("This blog is set favourite");
              } else {
                // Remove the blog from favorites
                // Implement local storage (e.g., SQLite, Hive) logic here
                print("This blog is removed from favourites");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(widget.imageUrl),
            const SizedBox(height: 16.0),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'This blog is incredibly important because it provides valuable insights and knowledge on a subject that can significantly impact your life. Reading this blog can broaden your understanding and help you make informed decisions. Its a must-read for anyone seeking to stay informed and make a positive impact.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}



