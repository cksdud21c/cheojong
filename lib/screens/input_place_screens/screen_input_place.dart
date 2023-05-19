import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/model_input_place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/screens/shared_screens/menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Input_place_Page extends StatelessWidget {
  const Input_place_Page({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InputPlaceModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 67, 117),
          title: Text(title),
        ),
        endDrawer : SafeArea(
          child:
            Menu(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              input_place(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Next_Button(),
            ],
          ),
        ),
        bottomNavigationBar: Bottombar(),
      ),
    );
  }
}

class input_place extends StatelessWidget {
  final _controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hplace = Provider.of<InputPlaceModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          _controller.text = ''; // clear prefixText
        },
        child: TextFormField(
          onChanged: (place) {
            hplace.setPlace(place); // update variable with user input
          },
          keyboardType: TextInputType.text,
          controller: _controller,
          decoration: InputDecoration(
            labelText: '가실 장소를 입력해주세요',
            hintText: '세종대학교.',
            suffixIcon: IconButton(
              onPressed: () => _controller.clear(),
              icon: Icon(Icons.clear),
            ),
          ),
        ),
      ),
    );
  }
}

class Next_Button extends StatelessWidget {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final hplace = Provider.of<InputPlaceModel>(context, listen: false);
    return TextButton(
        onPressed: () {
          if (hplace.place.isNotEmpty) {//입력받은 장소 텍스트가
            sendPlaceNameValueToServer(hplace.place);//여기다가 서버로 보내는 코드를 작성해야함.
          }
          Navigator.of(context).pushNamed('/screen_recommend_place');
        },
        child: Text(
          'NEXT',
        ));
  }
}

// 텍스트 값을 Flask 서버에 보내는 함수(보내지는거 확인완료.근데 애뮬레이터에서 한글이 안쳐짐. 이건 해결해야함.)
Future<String> sendPlaceNameValueToServer(String pn) async {
  var url = Uri.parse('http://35.184.46.56:5000/spacename');
  var data = {'place': pn};
  var body = json.encode(data);
  var response = await http.post(url, headers: {"Content-Type": "application/json"},
      body: body);
  if(response.statusCode == 200) {
    return response.body;
  }else{
    throw Exception('Failed to send place name to server');
  }
}
