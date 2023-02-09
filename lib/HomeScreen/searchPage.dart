import 'package:chat_application/HomeScreen/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  Map<String, dynamic>? userMap;
  final TextEditingController search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String chatRoomId(String? user1, String user2) {
    if (user1![0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(height: size.height / 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height / 10,
                    width: size.width,
                    child: TextField(
                      controller: search,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: GestureDetector(
                          //to be implemented
                          onTap: () {
                            onSearch();
                          },
                          child: const Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                userMap != null
                    ? ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            String roomId = chatRoomId(
                                _auth.currentUser!.displayName,
                                userMap!['name']);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatRoom(
                                  chatRoomId: roomId,
                                  userMap: userMap,
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.chat),
                        ),
                        title: Text(userMap!['name']),
                        subtitle: Text(userMap!['email']),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
