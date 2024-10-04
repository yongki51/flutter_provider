import 'dart:convert';
import 'package:flutter_application_provider/news/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiUrl =
      'https://saktiwebtools.cloud.co.id/BMS-API/PRIORITY/BM-PRIORITY-BNI01/api/v1/news/cs/list';

  Future<List<News>> fetchNews() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'coid': 'bni01', 'newscd': ''},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['message'];
      return data.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
