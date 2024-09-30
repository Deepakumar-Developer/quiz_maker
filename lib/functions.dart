import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

String appName = 'Quiz Maker';
String quizName = '';
int index = 0;
String userName = '';
List<Map<String, dynamic>> createQuiz = [
  {
    'question': 'what is your name',
    'optionCount': '4',
    'correctAnswer': '1',
    'option1': 'deepak',
    'option2': 'kumar',
    'option3': 'sri',
    'option4': 'man',
  },
];
List<Map<String, dynamic>> attendedQuiz = [];

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

void customStatusBar(var statusBarColor, systemNavigationBarColor,
    statusBarIconBrightness, systemNavigationBarIconBrightness) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: statusBarIconBrightness,
    systemNavigationBarColor: systemNavigationBarColor,
    systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
  ));
}

class Auth {
  Future<void> anonymousUser() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}

class DataHandler {
  Future<void> buildQuiz(BuildContext context) async {
    CollectionReference quiz =
        FirebaseFirestore.instance.collection('quizMaker');

    String dataQuizName =
        '${quizName.replaceAll(' ', '')}${DateTime.now().millisecondsSinceEpoch}';

    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      quiz = quiz
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(dataQuizName);
      for (var quizData in createQuiz) {
        if ("${quizData['question']}".isNotEmpty) {
          await quiz.doc().set(quizData);
        }
      }

      CollectionReference setQuizName = FirebaseFirestore.instance
          .collection('quizMaker')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('quizCreate');
      await setQuizName.doc(dataQuizName).set({
        'quizName': quizName,
        'user': FirebaseAuth.instance.currentUser!.uid,
        'url':
            'https://QuizMaker.app/${FirebaseAuth.instance.currentUser!.uid}/$dataQuizName/',
        'dateName': '${DateTime.now()}',
      });

      showToast('Quiz Creates Successfully', context);
    } else {
      showToast('Invalid auth', context);
    }
  }

  String mark = '--/--';
  Future<void> attendQuiz(String quizTitle, String mark) async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      CollectionReference setQuizName = FirebaseFirestore.instance
          .collection('quizMaker')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('quizAttend');
      await setQuizName.doc().set({
        'quizName': quizTitle,
        'mark': mark,
        'dateName': '${DateTime.now()}',
      });
    }
  }

  Future<void> addUrl(String url) async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      CollectionReference setQuizUrl = FirebaseFirestore.instance
          .collection('quizMaker')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('quizUrl');
      await setQuizUrl.doc().set({
        'quizUrl': url,
      });
    }
  }

  Future<void> setUserName(String name) async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      CollectionReference setQuizUrl = FirebaseFirestore.instance
          .collection('quizMaker')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('UserName');
      await setQuizUrl.doc('name').set({
        'UserName': name,
      });
    }
  }

  Future<void> addMyScore(
    String score,
    quizName,
    uid,
  ) async {
    CollectionReference myScore = FirebaseFirestore.instance
        .collection('quizMaker')
        .doc(uid)
        .collection('quizCreate');
    await myScore.doc(quizName).collection(quizName).doc().set({
      'userName': userName,
      'score': score,
    });
  }
}

showToast(String msg, BuildContext context) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:
          Theme.of(context).colorScheme.secondary.withOpacity(0.75),
      textColor: Theme.of(context).colorScheme.surface,
      fontSize: 16.0);
}
