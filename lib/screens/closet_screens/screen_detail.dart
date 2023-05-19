import 'package:flutter/material.dart';
import 'package:untitled/models/model_clothing_item.dart';

class DetailScreen extends StatelessWidget {
  ClothingItem item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        children: [
          Image.network(item.imageUrl),
          Text(item.description),
          // Add more details or customize the layout as needed
        ],
      ),
    );
  }
}
