import 'dart:typed_data';

import 'package:demo_chat/services/auth/auth_service.dart';
import 'package:demo_chat/components/my_button.dart';
import 'package:demo_chat/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  // register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    // password match -> create user
    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        _auth.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text,_usernameController.text, _image!);
      }
      catch (e) {
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

  //Image variable
  Uint8List? _image;

  //pick the image
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }
  }


  // select Image
  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 210, 210),
      body: SingleChildScrollView(
        child: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Text("Let's create an account for you"),
                const SizedBox(
                  height: 10,
                ),
          
                // Adding profile image
                Stack(
                  children: [
                    _image != null ?
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: MemoryImage(_image!),
                      ):
                      CircleAvatar(
                        radius: 100,
                        child: Icon(Icons.person, size: 70),
                      ),
                    Positioned(
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo,),
                        onPressed: selectImage,
                      ),
                      bottom: -10,
                      left: 150,
                    )
                  ],
                  
                ),
          
                const SizedBox(
                  height: 25,
                ),

                //email textfield
                MytextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: _usernameController,
                ),
          
                const SizedBox(
                  height: 10,
                ),
          
                //email textfield
                MytextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                ),
          
                const SizedBox(
                  height: 10,
                ),
          
                //pw textfield
                MytextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                ),
          
                const SizedBox(
                  height: 10,
                ),
          
                //confirmpw textfield
                MytextField(
                  hintText: "Confirm password",
                  obscureText: true,
                  controller: _confirmpasswordController,
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //login button
                MyButton(
                  text: "Register",
                  onTap: () => register(context),
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
                      onTap: widget.onTap,
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
      ),
    );
  }
}
