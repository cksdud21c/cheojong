// main.dart
// 현재 클라이언트 개발 중 : 서버에게 요청을 하고 응답을 기다리는 실행 프로그램이 클라이언트
// 플러터는 모든 것이 위젯임. 따라서 입력하는 위젯들을 각각 class로 구현해서 만들어줌
// 이메일 입력 위젯, 비밀번호 입력위젯. 등등
import 'package:flutter/material.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_login.dart';
import 'screens/screen_register.dart';
import 'screens/input_emotion_screens/screen_now_emotion.dart';
import 'screens/input_emotion_screens/screen_hope_emotion.dart';
import 'screens/input_place_screens/screen_input_place.dart';
import 'screens/input_place_screens/screen_recommend_place.dart';
import 'screens/input_emotion_screens/screen_recommend.dart';
import 'package:untitled/tabs/tab_calender.dart';
import 'package:untitled/tabs/tab_profile.dart';
import 'package:untitled/screens/closet_screens/screen_closet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/models/model_auth.dart';
import 'package:untitled/screens/closet_screens/screen_camera.dart';
import 'package:untitled/screens/screen_home.dart';
import 'package:untitled/screens/screen_info.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async { //async : main함수는 백그라운드에서 실행할꺼야.(비동기적)
  //왜 비동기? flutter는 main메소드를 앱의 시작점으로 하며, 서버 등에서 데이터를 가져와야 하므로
  WidgetsFlutterBinding.ensureInitialized();//async를 쓰면 반드시 runApp보다 먼저 써야하는 코드.(걍 플러터 위젯쓰려면 써야함)
  await initializeDateFormatting();
  await Firebase.initializeApp(//await A : A가 다 실행되기전까지 기다려라.
      options: DefaultFirebaseOptions.currentPlatform //기본 Firebase옵션으로 Firebase앱을 초기화.
  );
  runApp(MyApp());//따라서, 파이어베이스앱이 초기화가 되면 MyApp클래스 실행.
}

class MyApp extends StatelessWidget {//MyAPP은 StatelessWidget(상태X) ->Notion Stateless vs Stateful 참고
  @override
  Widget build(BuildContext context) {//BuildContext: 위젯트리에서 현재 위젯(MYApp)의 위치
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        //어쨌든 파이어베이스 프로바이더 생성.(로그인 정보 상태 관리를 위한)
      ],
      child: MaterialApp(
        title: 'Flutter Shopping mall',
        routes: { //앱에서 사용할 화면들의 경로를 지정. 화면이 다수일 경우 Navigator보다 편리
          '/login': (context) => LoginScreen(), //loginScreen의 경로는 /login.
          '/splash': (context) => SplashScreen(),//splashScreen의 경로는 /splash.
          '/register': (context) => RegisterScreen(), //registerScreen의 경로는 /register.
          '/now_emotion' : (context) => const Now_emotion_Page(title : '감정 입력'),
          '/hope_emotion' : (context) => const Hope_emotion_Page(title : '감정 입력'),
          '/closet' : (context) => const Closet_Page(title : '옷장'),
          '/calender' : (context) => TabCalender(),
          '/profile' : (context) => TabProfile(),
          '/input_place' : (context) => const Input_place_Page(title : '장소 입력'),
          '/camera' : (context) => const CameraExample(),
          '/home' : (context) =>Home(),
          '/info' : (context) => InfoScreen(),
          '/screen_recommend_place' : (context) => Recommend_Place(),
          '/screen_recommend' : (context) => Recommend(),
        },
        initialRoute: '/splash', //앱 실행시 처음 나오는 화면은 스플래시화면으로 설정.
      ),
    );
  }
}