//하단바의 달력버튼을 누르면 나오는 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabCalender extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '달력',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}