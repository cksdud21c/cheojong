import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();

}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
    showImage();
  }
  Future sendPictureToServer(String id) async {//찍은 or 갤러리의 이미지를 서버로 보내는 함수.
    File imageFile = File(_image!.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    // print(base64Image);
    Uri url = Uri.parse('http://35.184.46.56:5000/imgprocess');

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, // this header is essential to send json data
      body: jsonEncode([
        {'image': '$base64Image','ID':id}
      ]),
    );
    if(response.statusCode == 200) {
       return response.bodyBytes;
     }else{
     throw Exception('Failed to send text value to server');
     }

  }
  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final e  =user!.email;
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 67, 117),
          title: Text('옷 촬영'),
        ),
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25.0),
        showImage(),
        SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // 카메라 촬영 버튼
            FloatingActionButton(
              child: Icon(Icons.add_a_photo),
              tooltip: 'Pick Image',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('TIP'),
                      content: Text('Please make the whole picture of the clothes come out :)'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            getImage(ImageSource.camera);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            // 갤러리에서 이미지를 가져오는 버튼
            FloatingActionButton(
              child: Icon(Icons.wallpaper),
              tooltip: 'pick Iamge',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('TIP'),
                      content: Text('Please make the whole picture of the clothes come out :)'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            getImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.navigate_next),//다음버튼
              onPressed: () async {
                if (_image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No image')),
                  );
                } else {//이미지가 비어있지 않으면
                  // Display a progress indicator indicating that it is being analyzed
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text('analyzing image...'),
                          ],
                        ),
                      );
                    },
                  );

                  final Uint8List bytes = await sendPictureToServer(e!);
                  // Close the progress indicator
                  Navigator.of(context).pop();//이미지처리가 완료되면 로딩팝업 닫기.

                  showDialog(
                    context: context,
                    builder: (context) {
                      bool _isLoading = false;
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          content: _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Image.memory(bytes),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('OK'), //사용자가 이 사진을 사용하겠다고 ok하면
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                final String OKsign = await sendOkSignToServer(); //ok사인을 서버에게 전달하고, 서버는 해당 이미지를 firebase에 저장시킴이 완료됬음을 수신하면 OK리턴.
                                if (OKsign == "OK") {
                                  Navigator.of(context).pop();//옷 추가가 완료되면 로딩창이 닫힘.
                                  Navigator.of(context).pushNamed('/closet');//옷장 페이지로 이동.
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Communication error: Please close the app and restart it.'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      });
                    },
                  );
                }
              },
            ),



          ],
        )
      ],
      ),
    );
  }
}

// function to send image to Flask server
Future<String> sendOkSignToServer() async {
  var url = Uri.parse('http://34.64.223.190:5000/ok');
  var data = {'ok': "OK"};
  var body = json.encode(data);
  var response = await http.post(url, headers: {"Content-Type": "application/json"},
      body: body);
  if(response.statusCode == 200) {
    return "OK";
  }else{
    return "Fail";
  }
}