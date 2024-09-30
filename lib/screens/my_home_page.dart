import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_maker/functions.dart';
import 'package:quiz_maker/screens/my_Quiz_attended_page.dart';
import 'package:quiz_maker/screens/my_quiz_creation_page.dart';
import 'package:text_scroll/text_scroll.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool creation = true;
  final quizTitle = TextEditingController();
  var enterUrl = TextEditingController();
  String pm = 'PM';
  String am = 'AM';
  bool showLoader = false;
  final gradient =
      const LinearGradient(colors: [Color(0xff4942E4), Color(0xffF08080)]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.035),
                height: height(context),
                width: width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        if (int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) <
                                12 &&
                            int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) >=
                                6)
                          ShaderMask(
                            blendMode: BlendMode
                                .srcIn, // Only show gradient where text overlaps
                            shaderCallback: (bounds) => gradient.createShader(
                              Rect.fromLTWH(
                                  0.0, 0.0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              'Good Morning',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        if (int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) <
                                18 &&
                            int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) >=
                                12)
                          ShaderMask(
                            blendMode: BlendMode
                                .srcIn, // Only show gradient where text overlaps
                            shaderCallback: (bounds) => gradient.createShader(
                              Rect.fromLTWH(
                                  0.0, 0.0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              'Good Afternoon',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        if (int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) <
                                21 &&
                            int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) >=
                                18)
                          ShaderMask(
                            blendMode: BlendMode
                                .srcIn, // Only show gradient where text overlaps
                            shaderCallback: (bounds) => gradient.createShader(
                              Rect.fromLTWH(
                                  0.0, 0.0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              'Good Evening',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        if (int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) <
                                6 ||
                            int.parse((DateTime.now()
                                    .toString()
                                    .substring(10, 13))) >=
                                21)
                          ShaderMask(
                            blendMode: BlendMode
                                .srcIn, // Only show gradient where text overlaps
                            shaderCallback: (bounds) => gradient.createShader(
                              Rect.fromLTWH(
                                  0.0, 0.0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              'Good Night',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      width: width(context),
                      child: Text(
                        'Make your own task with Quiz Maker',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.b612(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Create Quiz',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: 20)),
                                ),
                                actions: [
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    width: width(context) * 0.8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.05),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                      border: Border(
                                          top: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5)),
                                          bottom: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5)),
                                          left: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5)),
                                          right: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5))),
                                    ),
                                    child: TextField(
                                      controller: quizTitle,
                                      cursorColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      decoration: InputDecoration(
                                        hintText: 'Quiz Title',
                                        hintStyle: GoogleFonts.b612(
                                            textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(0.5),
                                        )),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (quizTitle.text.isNotEmpty) {
                                          quizName = quizTitle.text.toString();
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyQuizCreationPage(
                                                      update: false,
                                                    )),
                                          );
                                        } else {
                                          showToast('Set title for your Quiz',
                                              context);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      child: Text(
                                        'Create',
                                        style: GoogleFonts.b612(
                                            textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: height(context) * 0.2,
                        width: width(context) * 0.95,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.surface,
                              size: 35,
                            ),
                            Text(
                              'Create',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontSize: 12.5)),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.5, horizontal: 5),
                          width: width(context) * 0.75,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.05),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border(
                                top: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5)),
                                bottom: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5)),
                                left: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5)),
                                right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5))),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: TextField(
                              controller: enterUrl,
                              cursorColor:
                                  Theme.of(context).colorScheme.secondary,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                hintText: 'Paste URL to attend',
                                suffixIcon: GestureDetector(
                                  onTap: () async {
                                    enterUrl.clear();
                                    await getClipboardContent();
                                  },
                                  child: Icon(
                                    Icons.paste_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 25,
                                  ),
                                ),
                                hintStyle: GoogleFonts.b612(
                                    textStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.5),
                                )),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (enterUrl.text.isEmpty) {
                              showToast('Enter Url', context);
                            } else {
                              setState(() {
                                showLoader = true;
                              });
                              if (await checkUrl(enterUrl.text)) {
                                DataHandler().addUrl(enterUrl.text);
                                getTask(enterUrl.text);
                                setState(() {
                                  Future.delayed(const Duration(milliseconds: 5000),
                                      () {
                                    setState(() {
                                      showLoader = false;
                                      showToast(
                                          'Invalid URL! Enter correct URL',
                                          context);
                                      enterUrl.clear();
                                    });
                                  });
                                });
                              } else {
                                showToast('Quiz Already Attend', context);
                                setState(() {
                                  enterUrl.clear();
                                  showLoader = false;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.link,
                              color: Theme.of(context).colorScheme.surface,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Creation',
                      style: GoogleFonts.b612(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          width: width(context) * 0.9,
                          height: 110,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('quizMaker')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('quizCreate')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: snapshot.data!.docs
                                        .map((quizDetails) =>
                                            createQuizBox(quizDetails))
                                        .toList());
                              }
                              return Center(
                                child: SpinKitChasingDots(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 50,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0),
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.25),
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Attended',
                      style: GoogleFonts.b612(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          width: width(context) * 0.9,
                          height: 110,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('quizMaker')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('quizAttend')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: snapshot.data!.docs
                                        .map((quizDetails) =>
                                            attendQuizBox(quizDetails))
                                        .toList());
                              }

                              return Center(
                                child: SpinKitChasingDots(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 60,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0),
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.25),
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: showLoader,
                child: Container(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  width: width(context),
                  height: height(context),
                )),
            Visibility(
                visible: showLoader,
                child: SizedBox(
                  width: width(context),
                  height: height(context),
                  child: Center(
                    child: SpinKitChasingDots(
                      color: Theme.of(context).colorScheme.secondary,
                      size: 100,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget createQuizBox(QueryDocumentSnapshot quizDetails) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Task Score',
                    style: GoogleFonts.b612(
                        textStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.75),
                            fontSize: 20.5,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                actions: [
                  SizedBox(
                    width: width(context),
                    height: height(context) * 0.3,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('quizMaker')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('quizCreate')
                          .doc(
                              '${quizDetails['url'].split('/')[quizDetails['url'].split('/').length - 2]}')
                          .collection(
                              '${quizDetails['url'].split('/')[quizDetails['url'].split('/').length - 2]}')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                              scrollDirection: Axis.vertical,
                              children: snapshot.data!.docs
                                  .map((scoreDetails) => scoreBox(scoreDetails))
                                  .toList());
                        }
                        return Center(
                          child: SpinKitChasingDots(
                            color: Theme.of(context).colorScheme.secondary,
                            size: 60,
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            });
      },
      child: Container(
          padding: const EdgeInsets.all(5),
          width: 150,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 130,
                  height: 25,
                  child: TextScroll(
                    quizDetails['quizName'],
                    intervalSpaces: 5,
                    velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                    pauseBetween: const Duration(milliseconds: 500),
                    mode: TextScrollMode.endless,
                    delayBefore: const Duration(milliseconds: 2000),
                    style: GoogleFonts.b612(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 15.5,
                            fontWeight: FontWeight.normal)),
                    textAlign: TextAlign.right,
                    selectable: true,
                  )),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: quizDetails['url']));
                  showToast('Url copied in clipboard', context);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.75),
                    ),
                    child: Icon(
                      Icons.copy_outlined,
                      color: Theme.of(context).colorScheme.surface,
                      size: 12.5,
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(
                quizDetails['dateName'].toString().substring(0, 10),
                style: GoogleFonts.b612(
                    textStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.75),
                        fontSize: 10.5,
                        fontWeight: FontWeight.normal)),
              ),
              Text(
                '${(int.parse(quizDetails['dateName'].toString().substring(11, 13)) > 12) ? int.parse(quizDetails['dateName'].toString().substring(11, 13)) - 12 : int.parse(quizDetails['dateName'].toString().substring(11, 13))}${quizDetails['dateName'].toString().substring(13, 16)} ${(int.parse(quizDetails['dateName'].toString().substring(11, 13)) > 13) ? pm : am}',
                style: GoogleFonts.b612(
                    textStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.75),
                        fontSize: 7.525,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          )),
    );
  }

  Widget attendQuizBox(QueryDocumentSnapshot quizDetails) {
    return Container(
        padding: const EdgeInsets.all(5),
        width: 150,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 130,
                height: 25,
                child: TextScroll(
                  quizDetails['quizName'],
                  intervalSpaces: 5,
                  velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                  pauseBetween: const Duration(milliseconds: 500),
                  mode: TextScrollMode.endless,
                  delayBefore: const Duration(milliseconds: 500),
                  style: GoogleFonts.b612(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 15.5,
                          fontWeight: FontWeight.normal)),
                  textAlign: TextAlign.right,
                  selectable: true,
                )),
            const Expanded(child: SizedBox()),
            Align(
              alignment: const Alignment(0, 0),
              child: Text(
                quizDetails['mark'],
                style: GoogleFonts.b612(
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20.5,
                        fontWeight: FontWeight.normal)),
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                quizDetails['dateName'].toString().substring(0, 10),
                style: GoogleFonts.b612(
                    textStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.75),
                        fontSize: 10.5,
                        fontWeight: FontWeight.normal)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${(int.parse(quizDetails['dateName'].toString().substring(11, 13)) > 12) ? int.parse(quizDetails['dateName'].toString().substring(11, 13)) - 12 : int.parse(quizDetails['dateName'].toString().substring(11, 13))}${quizDetails['dateName'].toString().substring(13, 16)} ${(int.parse(quizDetails['dateName'].toString().substring(11, 13)) > 13) ? pm : am}',
                style: GoogleFonts.b612(
                    textStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.75),
                        fontSize: 7.525,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ));
  }

  Widget scoreBox(QueryDocumentSnapshot scoreData) {
    return Container(
      width: width(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${scoreData['userName'].toString().substring(0, 1).toUpperCase()}${scoreData['userName'].toString().substring(1).toLowerCase()}',
            style: GoogleFonts.b612(
                textStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.75),
                    fontSize: 15.525,
                    fontWeight: FontWeight.normal)),
          ),
          Text(
            ' => ',
            style: GoogleFonts.b612(
                textStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.75),
                    fontSize: 15.525,
                    fontWeight: FontWeight.normal)),
          ),
          Text(
            '${scoreData['score']}',
            style: GoogleFonts.b612(
                textStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.75),
                    fontSize: 15.525,
                    fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }

  Future<void> getClipboardContent() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() {
      String storageURL = clipboardData?.text ?? "";
      if (storageURL.isEmpty) showToast('Not in copy', context);
      if (storageURL.contains('https://QuizMaker.app/')) {
        enterUrl.text = storageURL;
      } else {
        showToast('URL Invalid', context);
      }
    });
  }

  Future<void> getTask(String enterURL) async {
    try {
      List<String> url = enterURL.split('/');
      CollectionReference getTask =
          FirebaseFirestore.instance.collection('quizMaker');
      if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
        getTask =
            getTask.doc(url[url.length - 3]).collection(url[url.length - 2]);
        final querySnapshot = await getTask.get();
        if (querySnapshot.docs.isEmpty) {
          return;
        }

        final List<Map<String, dynamic>> quizData = [];
        for (var doc in querySnapshot.docs) {
          if (doc.data() != null) {
            final map =
                Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
            quizData.add(map);
          }
        }

        setState(() {
          attendedQuiz = quizData;
          showLoader = false;
        });
        showToast('Start the Quiz', context);
        if (attendedQuiz.isNotEmpty) {
          setState(() {
            showLoader = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyQuizAttendedPage(
                title: enterUrl.text
                    .split('/')[enterUrl.text.split('/').length - 2]
                    .substring(
                        0,
                        enterUrl.text
                                .split('/')[enterUrl.text.split('/').length - 2]
                                .length -
                            13),
                attendQuizName: enterUrl.text
                    .split('/')[enterUrl.text.split('/').length - 2],
                taskUid: enterUrl.text
                    .split('/')[enterUrl.text.split('/').length - 3],
              ),
            ),
          );
        } else {
          showToast('Invalid URL! Enter correct URL', context);
        }
      }
    } on FirebaseException catch (e) {
      // TODO
      showToast('Invalid URL! Enter correct URL', context);
debugPrint(e as String?);
      setState(() {
        showLoader = false;
      });
    }
  }

  Future<void> updateQuiz(String enterURL) async {
    try {
      List<String> url = enterURL.split('/');
      CollectionReference getTask =
          FirebaseFirestore.instance.collection('quizMaker');
      if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
        getTask =
            getTask.doc(url[url.length - 3]).collection(url[url.length - 2]);
        final querySnapshot = await getTask.get();
        if (querySnapshot.docs.isEmpty) {
          return;
        }

        final List<Map<String, dynamic>> quizData = [];
        for (var doc in querySnapshot.docs) {
          if (doc.data() != null) {
            final map =
                Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
            quizData.add(map);
          }
        }

        setState(() {
          createQuiz = quizData;
          showLoader = false;
        });
        showToast('Start the Quiz', context);

        setState(() {
          showLoader = false;
          quizName =
              url[url.length - 2].substring(0, url[url.length - 2].length - 13);
        });
        print(createQuiz);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyQuizCreationPage(update: true),
          ),
        );
      }
    } on FirebaseException catch (e) {
      // TODO
      showToast('Invalid URL! Enter correct URL', context);
      debugPrint(e as String?);

      setState(() {
        showLoader = false;
      });
    }
  }

  Future<bool> checkUrl(String url) async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      CollectionReference getUrl = FirebaseFirestore.instance
          .collection('quizMaker')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('quizUrl');
      final querySnapshot = await getUrl.get();
      if (querySnapshot.docs.isEmpty) {
        return true;
      }

      final List<String> quizUrl = [];
      for (var doc in querySnapshot.docs) {
        if (doc.data() != null) {
          final map =
              Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
          quizUrl.add(map['quizUrl']);
        }
      }
      return !quizUrl.contains(url);
    }
    return true;
  }

  Future<void> getUserName() async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      CollectionReference getName = FirebaseFirestore.instance
          .collection('quizMaker')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('UserName');
      final dataProfile = await getName.doc('name').get()
          as DocumentSnapshot<Map<String, dynamic>>;

      final data = dataProfile.data();
      if (data != null) {
        print(data);
        setState(() {
          userName = data['UserName'];
        });
      }
    }
  }
}
