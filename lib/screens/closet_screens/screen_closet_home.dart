import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/constants.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';
import 'package:untitled/screens/closet_screens/screen_camera.dart';

class Closet_home_Page extends StatelessWidget {
  const  Closet_home_Page({Key? key}) : super(key: key);
  //key : 상태를 기억해야할 때.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(//physics : scrollview의 물리(어떻게 스크롤 될지)를 선택하는 속성
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,//Column이므로 세로축기준 왼쪽 정렬.
          children: [
            Text(
              "Explore",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const Text(
              "best Outfits for you",
              style: TextStyle(fontSize: 18),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: SearchForm(),//searchForm위젯을 둘러싸는 패딩임.
            ),
            const Categories(),
            const NewArrivalProducts(),
            const PopularProducts(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFFFD725A),
        child: Icon(Icons.camera),
        onPressed: () {
         Navigator.pushNamed(context, '/camera');
         },
      ),
      floatingActionButtonLocation:
        FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
