import 'package:demo_chat/components/my_button.dart';
import 'package:demo_chat/components/my_textfield.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    }

    // catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 230, 217, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              width: 250,
              height: 400,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      Text("Login",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(164, 151, 134, 1),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //email textfield
                  MytextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: _emailController,
                    color: Color.fromRGBO(244, 244, 244, 1),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //pw textfield
                  MytextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: _passwordController,
                    color: Color.fromRGBO(244, 244, 244, 1),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  //login button
                  MyButton(
                    text: text("Login", Colors.white, 16),
                    onTap: () => login(context),
                    color: Color.fromRGBO(164, 151, 134, 1),
                    w: 200,
                    h: 70,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member? "),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "Register now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
