import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/model_input_emotion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/screens/shared_screens/menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Hope_emotion_Page extends StatelessWidget {
  const Hope_emotion_Page({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => InputEmotionModel(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 6, 67, 117),
            title: Text(title + ': 희망 감정'),
          ),
          endDrawer : SafeArea(
            child:
              Menu(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                hope_emotion_Input(),
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

class hope_emotion_Input extends StatelessWidget {
  final _controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hemotion = Provider.of<InputEmotionModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          _controller.text = ''; // clear prefixText
        },
        child: TextFormField(
          onChanged: (emotion) {
            hemotion.setEmotion(emotion); // update variable with user input
          },
          keyboardType: TextInputType.text,
          controller: _controller,
          decoration: InputDecoration(
            labelText: '희망하는 감정을 입력해주세요',
            hintText: '평온한 분위기를 느끼고 싶어.',
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
    final hemotion = Provider.of<InputEmotionModel>(context, listen: false);
    return TextButton(
        onPressed: () {
          if (hemotion.emotion.isNotEmpty) {//입력받은 감정 텍스트가 비어있지 않으면
            sendHopeEmotionToServer(hemotion.emotion);//여기다가 서버로 보내는 코드를 작성해야함.
          }
          Navigator.of(context).pushNamed("/screen_recommend");
          
        },
        child: Text(
          'NEXT',
        ));
  }
}

// 텍스트 값을 Flask 서버에 보내는 함수(보내지는거 확인완료.근데 애뮬레이터에서 한글이 안쳐짐. 이건 해결해야함.)
Future<String> sendHopeEmotionToServer(String he) async {
  var url = Uri.parse('http://35.184.46.56:5000/emotext');
  var data = {'text': he};
  var body = json.encode(data);
  var response = await http.post(url, headers: {"Content-Type": "application/json"},
      body: body);
  if(response.statusCode == 200) {
    return response.body;
  }else{
    throw Exception('Failed to send hope emotion value to server');
  }
}
