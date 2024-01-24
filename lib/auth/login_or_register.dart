import 'package:flutter/material.dart';
import 'package:friendly_spaces/auth/login_page.dart';
import 'package:friendly_spaces/auth/register_page.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({super.key});

  @override
  State<StatefulWidget> createState() => _LoginOrRegisterState();

}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  //initially, show a login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}