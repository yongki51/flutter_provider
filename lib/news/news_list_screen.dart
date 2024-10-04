import 'package:flutter/material.dart';
import 'package:flutter_application_provider/news/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider(), // Provider dibuat secara lokal
      child: PopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('News List'),
          ),
          body: Consumer<NewsProvider>(
            builder: (context, newsProvider, child) {
              if (newsProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (newsProvider.errorMessage.isNotEmpty) {
                return Center(child: Text(newsProvider.errorMessage));
              }

              if (newsProvider.newsList.isEmpty) {
                return const Center(child: Text('No news available.'));
              }

              return RefreshIndicator(
                onRefresh: () => newsProvider.getNews(),
                child: ListView.builder(
                  itemCount: newsProvider.newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsProvider.newsList[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Material(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(news.imageFile),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      news.newsname,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${DateFormat("dd MMM yyyy").format(DateTime.parse(news.validFrom))} - ${DateFormat("dd MMM yyyy").format(DateTime.parse(news.validTo))}",
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      news.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
