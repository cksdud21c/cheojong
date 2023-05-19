// screens/screen_register.dart
// 회원가입 화면
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/model_register.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 67, 117),
          title: Text('회원 정보 수정'),
        ),
        body: Container(
          child: ListView(
            children: [
              OldInput(),
              SexInput(),
            ],
          ),
        ),
      ),
    );
  }
}//회원가입화면 위젯
class SexInput extends StatefulWidget {
  @override
  State<SexInput> createState() => _SexInputState();
}

class _SexInputState extends State<SexInput> {
  final _sex = ['남성','여성'];
  String? _selectedSex;
  @override
  void initState(){
    super.initState();
    setState((){
      _selectedSex = _sex[0];
    });
  }
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false); //listen : UI를 새로 그려줄 필요는 없습니다.`
    return Container(
      padding: EdgeInsets.all(10),
      child:
      DropdownButtonFormField(
        value: _selectedSex,
        items: _sex.map(
                (e) => DropdownMenuItem(value : e, child : Text(e),)
        ).toList(),
        onChanged: (value){
          setState((){
            _selectedSex = value!;
            register.setsex(value);
          });
        },
        decoration: InputDecoration(
            labelText: "성별",
        ),
      ),
    );
  }
}//성별 입력 위젯

class OldInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(10),
      child: Consumer<RegisterModel>(
        builder: (context, register, _) {
          final ocontroller = TextEditingController(text: register.old);

          return TextField(
            onChanged: (old) {
              register.setold(old);
            },
            keyboardType: TextInputType.number,
            controller: ocontroller,
            decoration: InputDecoration(
              labelText: register.old,
              suffixIcon: IconButton(
                onPressed: () => ocontroller.clear(),
                icon: Icon(Icons.clear),
              ),
              hintText: register.old,
            ),
          );
        },
      ),
    );
  }
}


