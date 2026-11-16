import 'dart:convert';

import 'package:jsonplaceholder/model/albums.dart';
import 'package:jsonplaceholder/model/comments.dart';
import 'package:jsonplaceholder/model/photos.dart';
import 'package:jsonplaceholder/model/posts.dart';
import 'package:http/http.dart' as http;
import 'package:jsonplaceholder/model/todos.dart';
import 'package:jsonplaceholder/model/users.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  // endpoints posts
  static Future<List<Posts>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Posts.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat Posts (HTTP ${response.statusCode})');
    }
  }

  // endpoints albums
  static Future<List<Albums>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Albums.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat Albums (HTTP ${response.statusCode})');
    }
  }

  // endpoints comments
  static Future<List<Comments>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Comments .fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat Comments (HTTP ${response.statusCode})');
    }
  }

  // endpoints photos
  static Future<List<Photos>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Photos.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat Photos (HTTP ${response.statusCode})');
    }
  }

  // endpoints todos
  static Future<List<Todos>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Todos.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat Todos (HTTP ${response.statusCode})');
    }
  }

  // endpoints users
  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Users.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat Users (HTTP ${response.statusCode})');
    }
  }
}
