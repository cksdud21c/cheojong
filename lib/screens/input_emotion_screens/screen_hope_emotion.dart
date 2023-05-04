import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/model_auth.dart';
import 'package:untitled/models/model_input_emotion.dart';
import 'package:untitled/models/model_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          ),
    );
  }
}

var desiredEmotion = "";
class hope_emotion_Input extends StatelessWidget {
  final _controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          _controller.text = ''; // clear prefixText
        },
        child: TextFormField(
          onChanged: (emotion) {
            desiredEmotion = emotion; // update variable with user input
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
    return TextButton(
        onPressed: () {
          if (desiredEmotion.isNotEmpty) {//입력받은 감정 텍스트가 
            //여기다가 서버로 보내는 코드를 작성해야함.  
          }
          Navigator.of(context).pushNamed('/screen_place_recommend');
          
        },
        child: Text(
          'NEXT',
        ));
  }
}
