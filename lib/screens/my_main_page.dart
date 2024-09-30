import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/my_hero_page.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  @override
  Widget build(BuildContext context) {
    return MyHeroPage();
  }
}
