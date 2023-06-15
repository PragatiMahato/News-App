import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/auth.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _titlt() {
    return const Text("Firebase Auth");
  }

  Widget _userId() {
    return  Text( user?.email ?? "User email");
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
