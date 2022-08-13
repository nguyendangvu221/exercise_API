import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';

class Post{
  final int userId;
  final int id;
  final String title;
  final String body;
  Post(this.userId,this.id,this.title,this.body);
  factory Post.fromJsonObject(Map<String, dynamic> jsonObject){
    return Post(
      jsonObject["userId"] as int,
      jsonObject["id"] as int,
      jsonObject["title"] as String,
      jsonObject["body"]as String
    );
  }
}
Map <String, dynamic> convertJsonObject (String jsonString){
  final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
  return jsonObject;
}
Future<Post> getPostFromBackend() async {
  final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/4");
  final response = await get(uri);
  final jsonString = response.body;
  final jsonObject = convertJsonObject(jsonString);
  final post = Post.fromJsonObject(jsonObject);
  return post;
}
void doSomeThing(){
  getPostFromBackend().then((post) => {
    
  });
}