// screens/screen_register.dart
// 회원가입 화면
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/model_auth.dart';
import 'package:untitled/models/model_register.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text(
            '회원가입',
          ),
        ),
        body: Column(
          children: [
            EmailInput(),
            PasswordInput(),
            PasswordConfirmInput(),
            RegistButton()
          ],
        ),
      ),
    );
  }
}//회원가입화면 위젯

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    final e_controller = TextEditingController();//텍스트필드값 지우기 컨트롤러
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (email) {
          register.setEmail(email);//email값 변경
        },
        keyboardType: TextInputType.emailAddress,
        controller: e_controller,
        decoration: InputDecoration(
          labelText: '이메일',
          suffixIcon: IconButton(
            onPressed: () => e_controller.clear(),
            //suffixIcon(우측 X 아이콘)을 눌렀을 경우 clear
            icon: Icon(Icons.clear),
          ),
          hintText: 'MoodMatch@google.com',
        ),
      ),
    );
  }
}//이메일 입력 위젯
class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p_controller = TextEditingController();//텍스트 필드 값 지우기 컨트롤러
    final register = Provider.of<RegisterModel>(context);
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          register.setPassword(password);//password값 변경
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: '비밀번호 입력',
          hintText: '6자리 이상 입력해주세요',
          suffixIcon: IconButton(
            onPressed: () => p_controller.clear(),
            //suffixIcon(우측 X 아이콘)을 눌렀을 경우 clear
            icon: Icon(Icons.clear),
          ),
          errorText: register.password != register.passwordConfirm ? 'Password incorrect' : null,
        ),
      ),
    );
  }
}
class PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false); //listen : UI를 새로 그려줄 필요는 없습니다.`
    final _controller = TextEditingController();//텍스트필드값 지우기 컨트롤러
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          register.setPasswordConfirm(password);//passwordconfirm값 변경
        },
        obscureText: true,
        controller: _controller,
        decoration: InputDecoration(
          labelText: '비밀번호 확인',
          suffixIcon: IconButton(
            onPressed: () => _controller.clear(),
            //suffixIcon(우측 X 아이콘)을 눌렀을 경우 clear
            icon: Icon(Icons.clear),
          ),
          hintText: '동일한 비밀번호를 입력해주세요',
        ),
      ),
    );
  }
}//비밀번호 확인 입력 위젯

class RegistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    final register = Provider.of<RegisterModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7, //MedeiaQuery(앱 화면 크기를 알아냄.여기선 앱화면의 width)
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: (register.password != register.passwordConfirm) ? null : () async {//버튼을 눌렀을 떄 동일 비밀번호가 아니면
          await authClient
              .registerWithEmail(register.email, register.password)
              .then((registerStatus) {
            if (registerStatus == AuthStatus.registerSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('회원가입 성공')),
                );
              Navigator.pop(context);
              //Navigator.pop(context) : 화면이 스택구조로 쌓이게 되면 바로 전에 쌓인 화면으로 감.
              //즉, register전의 화면은 login화면이기 때문에 login화면에서 push로 넣어줘서 login이 담김.
              //따라서 현재에서 pop을 해주면 login화면으로 감.
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('회원가입 실패')),
                );
            }
          });
        },
        child: Text('회원가입'),
      ),
    );
  }
}//회원가입완료버튼 위젯
//..은 함수의 반환 객체를 뜻하는 다트 문법.
//쓰지 않으려면
// var scaffoldMessenger = ScaffoldMessenger.of(context)
// scaffoldMessenger.hideCurrentSnackBar()
// scaffoldMessenger.showSnackBar(SnackBar(content: Text('Regist Success!!')));
// 이거 써주면 됨.