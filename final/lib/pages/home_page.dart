import "package:cloud_firestore/cloud_firestore.dart";
import "package:demo_chat/components/group_tile.dart";
import "package:demo_chat/components/popup_textfield.dart";
import "package:demo_chat/components/widget.dart";
import "package:demo_chat/pages/chat_page.dart";
import "package:demo_chat/pages/creategroup_page.dart";
import "package:demo_chat/services/auth/auth_service.dart";
import "package:demo_chat/services/chat/chat_service.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";

class HomePage extends StatefulWidget {
  HomePage({super.key});
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // chat & auth service & firestore
  final ChatService _chatService = ChatService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  void initState() {
    super.initState();
    getlocation();
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

  void getlocation() async {
    _currentLocation = await _getCurrentLocation();
    print("${_currentLocation}");

    AuthService()
        .updateLocate(_currentLocation?.latitude, _currentLocation?.longitude);
  }

  void toCreateGroupPage(BuildContext context) {
    // go to create group page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroupPage(),
        ));
  }

  void logout() {
    //get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromRGBO(164, 151, 134, 1),
        leading: IconButton(
            onPressed: () => toProfilePage(context), icon: Icon(Icons.person)),
        actions: [
          IconButton(
              onPressed: () => joingroup(context),
              icon: const Icon(Icons.search)),
          Container(
              width: 1, color: const Color.fromRGBO(45, 61, 88, 1), height: 20),
          IconButton(
              onPressed: () => toEventListPage(context),
              icon: const Icon(Icons.notifications)),
        ],
      ),
      backgroundColor: Color.fromRGBO(244, 230, 217, 1),
      body: _buildGroupList(),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(164, 151, 134, 1),
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () => toCreateGroupPage(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  //

  // build a list of current user's groups
  Widget _buildGroupList() {
    return StreamBuilder(
        stream: _chatService.getGroupsStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          // loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          // create List of group
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (groupData) => _buildGroupListItem(groupData, context))
                .toList(),
          );
        });
  }

  // build individual list tile for group
  Widget _buildGroupListItem(
      Map<String, dynamic> groupData, BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection("groups").doc(groupData["gid"]).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error fetching data');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          final data = snapshot.data!.data()! as Map<String, dynamic>;
          return GroupTile(
            event_name: data["groupName"],
            event_description: data["description"],
            event_image: data["image"],
            gid: groupData["gid"],
            switchstate: groupData["enable"],
            onTap: () {
              // tapped on a group -> go to chat page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      groupName: data["groupName"],
                      gid: groupData["gid"],
                      g_latitude: data["Latitude"],
                      g_longtitude: data["Longtitude"],
                    ),
                  ));
            },
          );
        }
      },
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: nav_bar(context),
  //     body: StreamBuilder(
  //         stream: FirebaseFirestore.instance.collection("groups").snapshots(),
  //         builder: (context, snapshot) {
  //           int count = 0;
  //           return ListView.builder(
  //             scrollDirection: Axis.vertical,
  //             itemCount: snapshot.data?.docs.length,
  //             itemBuilder: (context, index) {
  //               print(snapshot.data?.docs[index]["groupName"]);
  //               print(snapshot.data?.docs[index]["description"]);
  //               print("------------------------------------------------");
  //               String event_name =
  //                   (snapshot.data?.docs[index]["groupName"]).toString();
  //               String event_description =
  //                   (snapshot.data?.docs[index]["description"]).toString();
  //               String event_image =
  //                   (snapshot.data?.docs[index]["image"]).toString();
  //               count += 1;
  //               print(count);
  //               return banner_group(event_name, event_description,count, event_image, context);
  //             },
  //           );
  //         }),
  //     backgroundColor: const Color.fromRGBO(244, 230, 217, 1),
  //     floatingActionButton: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Color.fromRGBO(164, 151, 134, 1),
  //         shape: CircleBorder(),
  //         padding: EdgeInsets.all(20),
  //       ),
  //       onPressed: () => toCreateGroupPage(context),
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.white,
  //         size: 30,
  //       ),
  //     ),
  //   );
  // }