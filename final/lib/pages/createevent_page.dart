// import 'dart:typed_data';

// import 'package:demo_chat/components/my_button.dart';
// import 'package:demo_chat/components/widget.dart';
// import 'package:demo_chat/services/event_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateEventPage extends StatefulWidget {
//   final String gid;
//   const CreateEventPage({super.key, required this.gid});

//   @override
//   State<CreateEventPage> createState() => _CreateEventPageState();
// }

// class _CreateEventPageState extends State<CreateEventPage> {
//   //textcontroller
//   final TextEditingController _eventNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();

//   //Image variable
//   Uint8List? _image;

//   //pick the image
//   pickImage(ImageSource source) async {
//     final ImagePicker _imagePicker = ImagePicker();
//     XFile? _file = await _imagePicker.pickImage(source: source);
//     if (_file != null) {
//       return await _file.readAsBytes();
//     }
//   }

//   // select Image
//   void selectImage() async {
//     Uint8List img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = img;
//     });
//   }

//   // select Date
//   Future<void> selectDate(BuildContext context) async {
//     DateTime? _picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2100));

//     if (_picked != null) {
//       setState(() {
//         _dateController.text = _picked.toString().split(" ")[0];
//       });
//     }
//   }

//   // select Time
//   Future<void> selectTime(BuildContext context) async {
//     TimeOfDay? _picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (_picked != null) {
//       setState(() {
//         _timeController.text =
//             _picked.hour.toString() + " : " + _picked.minute.toString();
//       });
//     }
//   }

//   //create event
//   void createEvent(BuildContext context) async {
//     //get chat service
//     final EventService _eventService = EventService();
//     await _eventService.addEvent(
//         widget.gid,
//         _eventNameController.text,
//         _dateController.text,
//         _dateController.text,
//         _timeController.text,
//         _image!);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Create Event"),
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
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.black, width: 2)),
//                   child: _image != null
//                       ? Image.memory(_image!)
//                       : Icon(
//                           Icons.image,
//                           size: 110,
//                         ),
//                 ),
//                 onTap: selectImage,
//               ),

//               SizedBox(
//                 height: 25,
//               ),

//               //Add group name
//               Text("Event Name :"),
//               TextFormField(
//                 decoration: InputDecoration(hintText: ""),
//                 controller: _eventNameController,
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               //Add description
//               Text("Description :"),
//               TextFormField(
//                 decoration: InputDecoration(hintText: ""),
//                 controller: _descriptionController,
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               //select date
//               TextFormField(
//                 decoration: InputDecoration(
//                     hintText: "Date", prefixIcon: Icon(Icons.calendar_today)),
//                 controller: _dateController,
//                 readOnly: true,
//                 onTap: () => selectDate(context),
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               //select time
//               TextFormField(
//                 decoration: InputDecoration(
//                     hintText: "Time",
//                     prefixIcon: Icon(Icons.access_time_outlined)),
//                 controller: _timeController,
//                 readOnly: true,
//                 onTap: () => selectTime(context),
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               // Submit button
//               MyButton(
//                 text: text("Login", Colors.white, 16),
//                 onTap: () => createEvent(context),
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

import 'package:demo_chat/components/widget.dart';
import 'package:demo_chat/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventPage extends StatefulWidget {
  final String gid;
  const CreateEventPage({super.key, required this.gid});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  //textcontroller
  var _eventNameController = new TextEditingController();
  var _dateController = new TextEditingController();
  var _time1Controller = new TextEditingController();
  var _time2Controller = new TextEditingController();
  var _detailController = new TextEditingController();

  //Image variable
  Uint8List? _image;

  //pick the image
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  // select Image
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  // select Date
  Future<void> selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  // select Time
  Future<void> selectTime1(BuildContext context) async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_picked != null) {
      setState(() {
        if(_picked.minute == 0){
            _time1Controller.text = _picked.hour.toString() + ":" +"00";
        }
        else{
            _time1Controller.text =
            _picked.hour.toString() + ":" + _picked.minute.toString();
        }
      });
    }
  }

  // select Time
  Future<void> selectTime2(BuildContext context) async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_picked != null) {
      setState(() {
        if(_picked.minute == 0){
            _time2Controller.text = _picked.hour.toString() + ":" +"00";
        }
        else{
            _time2Controller.text =
            _picked.hour.toString() + ":" + _picked.minute.toString();
        }
      });
    }
  }

  //create event
  void createEvent(BuildContext context) async {
    //get chat service
    final EventService _eventService = EventService();
    final String _time = "${_time1Controller.text}-${_time2Controller.text}";
    await _eventService.addEvent(widget.gid, _eventNameController.text,
        _detailController.text, _dateController.text, _time, _image!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: page_bar("Create Event", context),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 20),
          const SizedBox(
            width: 20,
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
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  icon: Icon(Icons.image_outlined),
                                  onPressed: () => {selectImage()},
                                  iconSize: 60,
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              text("Event name", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", _eventNameController),
              SizedBox(
                width: 25,
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
              text("Date", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () => selectDate(context),
                  icon: Icon(Icons.calendar_today)),
              textformfield("", _dateController),
              SizedBox(
                width: 25,
              ),
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
              text("Time", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () => selectTime1(context),
                  icon: Icon(Icons.access_time_outlined)),
              textformfield("", _time1Controller),
              IconButton(
                  onPressed: () => selectTime2(context),
                  icon: Icon(Icons.access_time_outlined)),
              textformfield("", _time2Controller),
              SizedBox(
                width: 40,
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
              text("Detail", Colors.black, 24),
              SizedBox(
                width: 10,
              ),
              textformfield("", _detailController),
              SizedBox(
                width: 25,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 260,
              ),
              ElevatedButton(
                onPressed: () => createEvent(context),
                child: const Text(
                  "Add",
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
              )
            ],
          ),
        ],
      )),
      backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
    );
  }
}
