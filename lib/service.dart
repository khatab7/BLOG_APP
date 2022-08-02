// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:projblog/person.dart';

class Api {
  Future<Post> deletPost(int id) async {
    final response = await http.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"),
    );
    if (response.statusCode == 200) {
      return //true;
          Post.fromJson(jsonDecode(response.body));
    } else {
      return throw Exception(
          'Failed to delet todo.${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': post.title!,
        'userId': post.userId,
        'body': post.body!
      }),
    );

    if (response.statusCode == 201) {
      //print(response.body);
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Post.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post.');
    }
  }

  Future<List<Post>> getAllPost() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Iterable postMap = jsonDecode(response.body);
      return List<Post>.from(postMap.map((e) => Post.fromJson(e)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<Post> updatePost(
    Post post,
  ) async {
    final response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/${post.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': post.title!,
        'body': post.body!,
        'userId': post.userId,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return Post.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update post.');
    }
  }
}
