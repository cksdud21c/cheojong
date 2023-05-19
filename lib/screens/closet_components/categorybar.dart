// categorybar.dart
import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final Function(String) onCategorySelected;

  CategoryBar({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryOption('All'),
          _buildCategoryOption('Outer'),
          _buildCategoryOption('Top'),
          _buildCategoryOption('Bottom'),
          _buildCategoryOption('Shoes'),
          _buildCategoryOption('Acc'),
          _buildCategoryOption('NoLabel'),
        ],
      ),
    );
  }

  Widget _buildCategoryOption(String categoryName) {
    return GestureDetector(
      onTap: () => onCategorySelected(categoryName),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Text(
          categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
