import 'package:flutter/material.dart';
import 'package:flutter_application_provider/market.dart';
import 'package:flutter_application_provider/news/news_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Column(
        children: [
          MenuButton(),
          MenuButton(
            title: "Market",
            page: MarketPage(),
          )
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Widget page;

  const MenuButton({
    super.key,
    this.title = 'News List',
    this.page = const NewsListScreen(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke NewsListScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        child: Text('Go to $title'),
      ),
    );
  }
}
