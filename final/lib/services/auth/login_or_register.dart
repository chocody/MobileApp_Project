import 'package:demo_chat/pages/login_page.dart';
import 'package:demo_chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({super.key});
  
  @override
  State<StatefulWidget> createState() => _LoginOrRegister();
}

class _LoginOrRegister extends State<LoginOrRegister> {
  
  // initially, show login page
  bool showLoginPage = true;

  // toggle between login and register
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
    }
    else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }

  

  
}