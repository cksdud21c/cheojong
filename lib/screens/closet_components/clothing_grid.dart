import 'package:flutter/material.dart';
import 'package:untitled/models/model_clothing_item.dart';
import 'package:untitled/screens/closet_screens/screen_detail.dart';
class ClothingGrid extends StatefulWidget {
  final List<ClothingItem> clothingItems;

  ClothingGrid({required this.clothingItems});

  @override
  State<ClothingGrid> createState() => _ClothingGridState();
}

class _ClothingGridState extends State<ClothingGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, //수평방향에 몇개 둘꺼니
      shrinkWrap: true, //가능한 작은 공간에 맞추도록 설정.
      children: List.generate(widget.clothingItems.length, (index) {//clothingItems의 길이 만큼 위젯 목록 생성.
        return GestureDetector(
          onTap: () {
            _showDetailScreen(context, widget.clothingItems[index]);
          },
          child: Image.network(//이미지의 url을 로드하여 화면에 표시.
            widget.clothingItems[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }

  void _showDetailScreen(BuildContext context, ClothingItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(item: item),
      ),
    );
  }
}
