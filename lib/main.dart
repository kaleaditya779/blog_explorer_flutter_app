import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'imageCheck.dart';
import 'BlogDetail.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextStyle _textStyle = const TextStyle(
    fontSize: 24.0,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  List<String> texts = ["WELCOME", "TO", "ADITYA'S", "BLOG", "EXPLORER"];
  int currentIndex = 0;
  bool isBlinking = true;

  @override
  void initState() {
    super.initState();
    _startBlinkingText();
  }

  void _startBlinkingText() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % texts.length;
        isBlinking = !isBlinking;
      });
    });
  }

  // This function will be invoked when the floating button of the 1st page is clicked..
  void navConnFunc(BuildContext context) async {
    Map<String, dynamic> data;
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        // print('Response data: ${response.body}');
        data = json.decode(response.body);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConnList(data: data)));

      } else {
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('BLOG EXPLORER'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < texts.length; i++)
                    AnimatedDefaultTextStyle(
                      style: _textStyle.copyWith(
                        fontSize: isBlinking ? 24.0 : 32.0,
                        color: isBlinking ? Colors.blue : Colors.red,
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: Text(texts[i]),
                    ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navConnFunc(context);
              },
              child: const Icon(Icons.arrow_forward),
            ),
          );
        }
      ),

    );
  }
}


class ConnList extends StatelessWidget {
  final Map<String, dynamic> data;
  const ConnList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOGS'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (var blog in data['blogs'])
                if (blog['image_url'] != null)
                  CustomContainer(
                    imageUrl: blog['image_url'],
                    title: blog['title'],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CustomContainer({super.key, 
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetail (
              imageUrl: imageUrl,
              title: title,
              //sampleText: 'This blog is incredibly important because it provides valuable insights and knowledge on a subject that can significantly impact your life. Reading this blog can broaden your understanding and help you make informed decisions. Its a must-read for anyone seeking to stay informed and make a positive impact.',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            loadImage(imageUrl), // Assuming loadImage is a custom function to load the image
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Change text color
              ),
            ),
          ],
        )
      ),
    );
  }
}
