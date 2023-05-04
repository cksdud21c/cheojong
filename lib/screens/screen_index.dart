//screens/screen_index.dart
//홈화면
//파란색은 다 클래스 이름임.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/tabs/tab_home.dart';
import 'package:untitled/tabs/tab_profile.dart';
import 'package:untitled/tabs/tab_calender.dart';
class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() {
    return _IndexScreenState();
  }
}
class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 1;
  //currentIndex : 하단바 중 어떤 것(달력?홈?프로필?)을 눌렀 는지 알기 위한 상태 변수.
  //0이면 캘린더, 1이면 홈, 2면 프로필 버튼을 누른 상태.
  final List<Widget> tabs = [
    TabCalender(),
    TabHome(),
    TabProfile(),
  ];//화면전환 위젯

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //fixed : 클릭되었을 때 커진다거나 라벨이 fade in한다던가 이벤트는 발생하지 않음.
        iconSize: 44,
        selectedItemColor: Colors.blue, //선택시 컬러는 블루
        unselectedItemColor: Colors.grey, //미선택시 컬러는 그레이
        selectedLabelStyle: TextStyle(fontSize: 12), //하단바 디자인
        currentIndex: _currentIndex,
        onTap: (index) { //index는 bottomNavigationBar 위젯 자체에서 전달됨. 달력이 0,홈이 1,프로필이 2겠네.
          setState(() { //setState()하면 다시 build( Widget build(BuildContext context)부터 다시 실행해서 화면을 그림.)
            _currentIndex = index;
          });
        }, //터치 했을 경우 상태 변경
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: '달력'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],//하단바 항목
      ),
      body: tabs[_currentIndex],//하단바를 사용할 때 중앙 화면은 body.하단 탭이 변경될 때마다 body에 나오는 화면만 바꿔 주면 됨.
    );
  }
}