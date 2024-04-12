import 'package:demo/widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

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
              child: IconButton(
                onPressed: () => {},
                icon: Icon(Icons.image_outlined,
                    size: 60, color: Color.fromRGBO(188, 190, 192, 1)),
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
              textfield(""),
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
              textfield(""),
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
                      print("${_currentLocation}");
                      print("${_currentAddress}");
                    }, // Handle button press action
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
                onPressed: () {},
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
