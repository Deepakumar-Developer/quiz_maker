import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_auth_page.dart';
import 'my_home_page.dart';

class MyGatePage extends StatefulWidget {
  const MyGatePage({super.key});

  @override
  State<MyGatePage> createState() => _MyGatePageState();
}

class _MyGatePageState extends State<MyGatePage> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return const MyAuthPage();
    }
    return const MyHomePage();
  }
}
