// import 'dart:typed_data';

// import 'package:demo_chat/components/my_button.dart';
// import 'package:demo_chat/components/widget.dart';
// import 'package:demo_chat/services/chat/chat_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateGroupPage extends StatefulWidget {
//   const CreateGroupPage({super.key});

//   @override
//   State<CreateGroupPage> createState() => _CreateGroupPageState();
// }

// class _CreateGroupPageState extends State<CreateGroupPage> {
//   //textcontroller
//   final TextEditingController _groupNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   //Image variable
//   Uint8List? _image;

//   //pick the image
//   pickImage(ImageSource source) async {
//     final ImagePicker _imagePicker = ImagePicker();
//     XFile? _file = await _imagePicker.pickImage(source: source);
//     if(_file != null){
//       return await _file.readAsBytes();
//     }
//   }

//   // select Image
//   void selectImage() async{
//     Uint8List img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = img ;
//     });
//   }

//   //create group
//   void createGroup(BuildContext context) {
//     //get chat service
//     final ChatService _chat = ChatService();
//     _chat.addGroup(_groupNameController.text,_descriptionController.text,_image!);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Create Group"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //Add image
//               GestureDetector(
//                 child: Container(
//                   width: 400,
//                   height: 250,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black, width: 2)
//                   ),
//                   child: _image != null ? Image.memory(_image!): Icon(Icons.image, size: 110,),
//                 ),
//                 onTap: selectImage,
//               ),

//               SizedBox(
//                 height: 25,
//               ),

//               //Add group name
//               Text("Group Name :"),
//               TextFormField(
//                 decoration: InputDecoration(
//                   hintText: ""
//                 ),
//                 controller: _groupNameController,
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               //Add description
//               Text("Description :"),
//               TextFormField(
//                 decoration: InputDecoration(
//                   hintText: ""
//                 ),
//                 controller: _descriptionController,
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               // Submit button
//               MyButton(
//                 text: text("CREATE GROUP",Colors.white,16),
//                 onTap: () => createGroup(context),
//                 color: Color.fromRGBO(164, 151, 134, 1),
//                 w: 200,
//                 h: 70,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  State<CreateGroupPage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<CreateGroupPage> {
  var groupnameController = new TextEditingController();
  var descriptionController = new TextEditingController();

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  final firestore = FirebaseFirestore.instance;
  String _currentAddress = "";
  Uint8List? _image;

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

    void createGroup(BuildContext context) {
    //get chat service
    final ChatService _chat = ChatService();
    _chat.addGroup(groupnameController.text,descriptionController.text,_image!,"${_currentAddress}",_currentLocation!.latitude,_currentLocation!.longitude);
    Navigator.pop(context);
  }

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placesmark = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);

      Placemark place = placesmark[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: page_bar("Create Group", context),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 300.0,
            height: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2.5,
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child:
                          _image != null ? Image.memory(_image!): IconButton(icon: Icon(Icons.image_outlined),onPressed: () => {selectImage()},iconSize: 60,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Group name", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", groupnameController),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Description", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", descriptionController),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Location", Colors.black, 24),
              SizedBox(
                width: 5,
              ),
              Stack(
                children: [
                  Positioned(
                      bottom: 9,
                      right: 9,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.5,
                          ),
                        ),
                      )),
                  IconButton(
                    onPressed: () async {
                      _currentLocation = await _getCurrentLocation();
                      await _getAddressFromCoordinates();
                      // print("${_currentLocation}");
                      // print("${_currentAddress}");
                    },
                    icon: Icon(Icons.location_on_outlined,
                        size: 25, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 240,
              ),
              ElevatedButton(
                onPressed: () => createGroup(context),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(164, 151, 134, 1),
                ),
              ),
            ],
          ),
        ],
      )),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
