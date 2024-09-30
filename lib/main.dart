import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/my_hero_page.dart';

import 'firebase_options.dart';
import 'functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    customStatusBar(const Color(0xffFEFAF6), const Color(0xffFEFAF6),
        Brightness.dark, Brightness.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Maker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff4942E4),
          surface: const Color(0xffFEFAF6),
          secondary: const Color(0xff4942E4),
          tertiary: const Color(0xff0f0f0f),
        ),
        useMaterial3: true,
      ),
      home: const MyHeroPage(),
    );
  }
}
