import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/model_auth.dart';
import 'package:untitled/models/model_input_place.dart';
import 'package:untitled/models/model_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      ),
    );
  }
}

var desiredEmotion = "";
class input_place extends StatelessWidget {
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
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/screen_place_recommend');
        },
        child: Text(
          'NEXT',
        ));
  }
}
