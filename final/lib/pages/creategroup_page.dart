import 'dart:typed_data';

import 'package:demo_chat/components/my_button.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';



class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  //textcontroller
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

  //create group
  void createGroup(BuildContext context) {
    //get chat service
    final ChatService _chat = ChatService();
    _chat.addGroup(_groupNameController.text,_descriptionController.text,_image!);
    Navigator.pop(context);
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Add image
              GestureDetector(
                child: Container(
                  width: 400, 
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2)
                  ),
                  child: _image != null ? Image.memory(_image!): Icon(Icons.image, size: 110,),
                ),
                onTap: selectImage,
              ),
          
              SizedBox(
                height: 25,
              ),
        
              //Add group name
              Text("Group Name :"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: ""
                ),
                controller: _groupNameController,
              ),
          
              SizedBox(
                height: 10,
              ),
        
              //Add description
              Text("Description :"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: ""
                ),
                controller: _descriptionController,
              ),

              SizedBox(
                height: 10,
              ),

              // Submit button
              MyButton(
                text: text("Login", Colors.white, 16),
                onTap: () => createGroup(context),
                color: Color.fromRGBO(164, 151, 134, 1),
                w: 200,
                h: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}