import 'package:bash_gid/const.dart';
import 'package:bash_gid/core/authorization.dart';
import 'package:bash_gid/features/auth/data/models/person.dart';
import 'package:bash_gid/theme.dart';
import 'package:bash_gid/components/default_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AuthorizationPage extends StatefulWidget{
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _userName = '';
  String _email = '';
  String _password = '';
  bool showRegister = false;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    Widget _logo(){
      return Padding(
          padding: EdgeInsets.only(top: 50, bottom: 30),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 200, width: 200,),
                Text('BashGid', style: kLightTheme.textTheme.titleLarge),
              ],
            ),
          ),
        ),
      );
    }

    Widget _button(String text, void func()){
      return ElevatedButton(
          style: kButtonStyle,
          onPressed: func,
          child: Text(text),
      );
    }

    Widget _form(String label, void func()){
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: input(Icon(Icons.email), inputAuthEmail, _emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: input(Icon(Icons.password), inputAuthPassword, _passwordController, true),
            ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: _button(label, func),
                ),
            )
          ],
        ),
      );
    }

    void _loginUserButtonAction() async {
      _userName = _userNameController.text;
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User? user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null){
       // SmartDialog.showToast('Не удалось войти! Проверьте введенный Email или пароль');
      }else{
        _userNameController.clear();
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerUserButtonAction() async {
      _userName = _userNameController.text;
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User? user = await _authService.registerInWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null){
        //SmartDialog.showToast('Не удалось зарегистрироваться! Проверьте введенный Email или пароль');
      }else{
        _userNameController.clear();
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Container(
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          toolbarHeight: 15,
          // title: Text('BashGid'),
          // leading: Icon(Icons.explore),
        ),
        body: Column(
            children: <Widget>[
              _logo(),
              (
                  showRegister ?
                  Column(
                    children: <Widget>[
                      /*Container(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: input(Icon(Icons.account_box_rounded), inputAuthUserName, _userNameController, false),
                        ),
                      ),*/
                      _form(buttonAuthRegistration,_registerUserButtonAction),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: GestureDetector(
                          child: Text(textAuthAlreadyRegistered),
                           onTap: (){
                            setState(() {
                              showRegister = false;
                            });
                           },
                        ),
                      ),
                    ],
                  )
                  :
                  Column(
                    children: <Widget>[
                      _form(buttonAuthLogin,_loginUserButtonAction),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: GestureDetector(
                          child: Text(textAuthNotRegistered),
                          onTap: (){
                            setState(() {
                              showRegister = true;
                            });
                          },
                        ),
                      ),
                    ],
                  )
              )
            ],
        ),
      ),
    );
  }
}


