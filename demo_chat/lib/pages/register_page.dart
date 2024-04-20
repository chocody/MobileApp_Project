import 'package:demo_chat/components/my_button.dart';
import 'package:demo_chat/components/my_textfield.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    // password match -> create user
    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        _auth.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    // password dont match -> tell user fix
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match!"),
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
            // logo
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                text("Let's create an account for you", Colors.black, 14),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            //email textfield
            MytextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
              color: Colors.white,
            ),

            const SizedBox(
              height: 10,
            ),

            //pw textfield
            MytextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
              color: Colors.white,
            ),

            const SizedBox(
              height: 10,
            ),

            //confirmpw textfield
            MytextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmpasswordController,
              color: Colors.white,
            ),

            const SizedBox(
              height: 25,
            ),

            //login button
            MyButton(
              text: text("Register", Colors.white, 16),
              onTap: () => register(context),
              color: Color.fromRGBO(164, 151, 134, 1),
              w: 310,
              h: 70,
            ),

            const SizedBox(
              height: 25,
            ),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
