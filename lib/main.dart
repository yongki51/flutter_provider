import 'package:flutter/material.dart';
import 'package:flutter_application_provider/dashboard_screen.dart';
import 'package:flutter_application_provider/news/news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => NewsProvider()),
    //   ],
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DashboardScreen(),
      // home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text("News List")),
        body: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () => newsProvider.getNews(),
                  child: const Icon(Icons.refresh),
                ),
                newsProvider.isLoading
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: newsProvider.newsList.length,
                          itemBuilder: (context, index) {
                            final news = newsProvider.newsList[index];
                            return ListTile(
                              title: Text(news.newsname),
                              subtitle: Text(news.description),
                            );
                          },
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
