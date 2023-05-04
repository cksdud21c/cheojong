import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/screens/closet_screens/screen_closet_home.dart';
import 'package:untitled/screens/screen_index.dart';
class Closet_Page extends StatelessWidget {
  const Closet_Page({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 67, 117),
        title: Text(title),
      ),
      body: const HomeScreen(),
    );
  }
}