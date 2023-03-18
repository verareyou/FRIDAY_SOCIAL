import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  String username = "";

  @override
  void initState() {
    super.initState();

    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          username,
          style: TextStyle(color: lightTextColor,fontWeight: FontWeight.bold,fontSize: 20),
        ),
      ),
    );
  }
}
