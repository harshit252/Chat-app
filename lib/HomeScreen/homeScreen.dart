import 'package:chat_application/Authenticate/methods.dart';
import 'package:chat_application/HomeScreen/searchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //online
      setStatus("Online");
    } else {
      //offline
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height / 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.withOpacity(0.35),
                      child: const Icon(Icons.person,
                          size: 30, color: Colors.black38)),
                  const Text(
                    "CHATS",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        textBaseline: TextBaseline.alphabetic),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                    child: const Icon(Icons.person_add_alt_1,
                        size: 40, color: Colors.brown),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            TextButton(
                onPressed: () {
                  logout(context);
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
