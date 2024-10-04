import 'package:flutter/material.dart';
import 'package:flutter_application_provider/news/news_model.dart';
import 'package:flutter_application_provider/news/news_service.dart';

class NewsProvider with ChangeNotifier {
  List<News> _newsList = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<News> get newsList => _newsList;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final NewsService _newsService = NewsService();

  NewsProvider() {
    getNews();
  }

  Future<void> getNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _newsList = await _newsService.fetchNews();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
