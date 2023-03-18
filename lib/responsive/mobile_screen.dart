import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/provider/user_provider.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  
  @override
  Widget build(BuildContext context) {

    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Text(
          user.username,
          style: GoogleFonts.spaceMono(color: lightTextColor,fontWeight: FontWeight.w100,fontSize: 40),
        ),
      ),
    );
  }
}
