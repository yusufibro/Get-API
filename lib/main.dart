import 'package:class_api/model/post_response.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PostPage());
  }
}

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<PostResponse> posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: getHttp,
                child: Text('Click'),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: posts.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text(posts[index].title);
                  })
            ],
          ),
        ),
      ),
    );
  }

  void getHttp() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/albums');
      // setState(() {
      //   posts = response.data;
      //   print(posts);
      // });
      for (var post in response.data) {
        print(post);
        posts.add(PostResponse.fromJson(post));
      }
      setState(() {});
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
