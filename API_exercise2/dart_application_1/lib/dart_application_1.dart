import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  Post(this.userId, this.id, this.title, this.body);
  factory Post.fromJsonObject(Map<String, dynamic> jsonObject) {
    return Post(jsonObject["userId"] as int, jsonObject["id"] as int,
        jsonObject["title"] as String, jsonObject["body"] as String);
  }
}

List<dynamic> convertJsonObject(String jsonString) {
  List<dynamic> jsonObject = jsonDecode(jsonString);
  return jsonObject;
}

List<Post> convertToPostList(List<dynamic> jsonObject) {
  List<Post> listPost = [];
  for (var i = 0; i < jsonObject.length; i++) {
    listPost.add(Post.fromJsonObject(jsonObject[i]));
  }
  return listPost;
}

Future<List<Post>> getPostFromBackend() async {
  final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  final response = await get(uri);
  final jsonString = response.body;
  final jsonObject = convertJsonObject(jsonString);
  final listPost = convertToPostList(jsonObject);
  return listPost;
}

void outputInfo() {
  getPostFromBackend().then((listPost) => {
        for (int i = 0; i < listPost.length; i++)
          {
            print("userId: ${listPost[i].userId}"),
            print("ID: ${listPost[i].id}"),
            print("title: ${listPost[i].title}"),
            print("body: ${listPost[i].body}"),
          }
      });
}

void main(List<String> args) {
  outputInfo();
}
