import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  var groupnameController = new TextEditingController();
  var descriptionController = new TextEditingController();

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  final firestore = FirebaseFirestore.instance;
  File? _image;

  String _currentAddress = "";

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
                              _image == null ? Text("") : Image.file(_image!),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: (60),
                    left: (120),
                    child: Visibility(
                      visible:
                          _image == null, // Button visible only when no image
                      child: IconButton(
                        icon: Icon(Icons.image_outlined),
                        onPressed: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _image = File(image.path);
                            });
                          }
                        },
                      ),
                    ),
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
                onPressed: () async {
                  var imagecheck = true;
                  var imageName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  var storageRef = FirebaseStorage.instance
                      .ref()
                      .child('coverpage/$imageName.jpg');
                  if (_image == null) {
                    imagecheck = false;
                  }
                  if (groupnameController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      imagecheck == false ||
                      _currentAddress.toString() == "") {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            title: const Text('Alert'),
                            content:
                                const Text('Please provide all information')));
                  } else {
                    var uploadTask = storageRef.putFile(_image!);
                    var downloadUrl =
                        await (await uploadTask).ref.getDownloadURL();
                    firestore.collection("Group Detail").add({
                      "Group name": groupnameController.text,
                      "Description": descriptionController.text,
                      "Address": "${_currentAddress}",
                      "Latitude": _currentLocation!.latitude,
                      "Longtitude": _currentLocation!.longitude,
                      "Image": downloadUrl.toString(),
                      "Users": [],
                    });
                    Navigator.of(context).pop();
                    groupnameController.clear();
                    descriptionController.clear();
                  }
                },
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
