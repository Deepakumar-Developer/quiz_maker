import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../functions.dart';
import 'my_home_page.dart';

class MyQuizAttendedPage extends StatefulWidget {
  final title;
  final attendQuizName;
  final taskUid;
  const MyQuizAttendedPage(
      {super.key,
      required this.title,
      required this.attendQuizName,
      required this.taskUid});

  @override
  State<MyQuizAttendedPage> createState() => _MyQuizAttendedPageState();
}

class _MyQuizAttendedPageState extends State<MyQuizAttendedPage> {
  final _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));
  final _pageViewController = PageController();
  List<int> onSelect = List<int>.filled(attendedQuiz.length, 0);
  int correctAnswer = 0;
  bool showScore = true;

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerCenter.stop();
  }

  @override
  Widget build(BuildContext context) {
    if (!onSelect.contains(0)) {
      _controllerCenter.play();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          if (!onSelect.contains(0))
            IconButton(
                onPressed: () {
                  setState(() {
                    showScore = true;
                    _controllerCenter.play();
                  });
                },
                icon: const Icon(Icons.leaderboard)),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Are You want to go back',
                          style: GoogleFonts.b612(
                              textStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 15.5)),
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'cancel',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: 12.5)),
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  DataHandler().attendQuiz(widget.title,
                                      '$correctAnswer/${attendedQuiz.length}');
                                  DataHandler().addMyScore(
                                      '$correctAnswer/${attendedQuiz.length}',
                                      widget.attendQuizName,
                                      widget.taskUid);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage()),
                                  );
                                },
                                child: Text(
                                  ' Exit ',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: 12.5)),
                                )),
                          ],
                        )
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: width(context),
        height: height(context),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              children: [
                SizedBox(
                    width: width(context),
                    height: height(context) * 0.725 + 40,
                    child: PageView.builder(
                      controller: _pageViewController,
                      itemCount: attendedQuiz.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                width: width(context),
                                height: 7.5,
                              ),
                              SizedBox(
                                  width: width(context),
                                  height: height(context) * 0.725,
                                  child: Container(
                                    width: width(context),
                                    height: height(context),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.1),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: ListView(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          attendedQuiz[index]['question'],
                                          style:
                                              GoogleFonts.b612(fontSize: 17.5),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(0.75),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        if (int.parse(attendedQuiz[index]
                                                ['optionCount']) >=
                                            1)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (onSelect[index] == 0) {
                                                  HapticFeedback.vibrate();
                                                  onSelect[index] = 1;
                                                  if (attendedQuiz[index]
                                                          ['correctAnswer'] ==
                                                      '1') {
                                                    correctAnswer += 1;
                                                  }
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                              margin:
                                                  const EdgeInsets.only(bottom: 15),
                                              decoration: BoxDecoration(
                                                  color: onSelect[index] == 1
                                                      ? attendedQuiz[index][
                                                                  'correctAnswer'] ==
                                                              '1'
                                                          ? Colors
                                                              .green.shade400
                                                          : Colors.red.shade400
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.15),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(
                                                'A) ${attendedQuiz[index]['option1']}',
                                                style: GoogleFonts.b612(
                                                    fontSize: 15.5),
                                              ),
                                            ),
                                          ),
                                        if (int.parse(attendedQuiz[index]
                                                ['optionCount']) >=
                                            2)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (onSelect[index] == 0) {
                                                  HapticFeedback.vibrate();
                                                  onSelect[index] = 2;
                                                  if (attendedQuiz[index]
                                                          ['correctAnswer'] ==
                                                      '2') {
                                                    correctAnswer += 1;
                                                  }
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                              margin:
                                                  const EdgeInsets.only(bottom: 15),
                                              decoration: BoxDecoration(
                                                  color: onSelect[index] == 2
                                                      ? attendedQuiz[index][
                                                                  'correctAnswer'] ==
                                                              '2'
                                                          ? Colors
                                                              .green.shade400
                                                          : Colors.red.shade400
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.15),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(
                                                'B) ${attendedQuiz[index]['option2']}',
                                                style: GoogleFonts.b612(
                                                    fontSize: 15.5),
                                              ),
                                            ),
                                          ),
                                        if (int.parse(attendedQuiz[index]
                                                ['optionCount']) >=
                                            3)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (onSelect[index] == 0) {
                                                  HapticFeedback.vibrate();
                                                  onSelect[index] = 3;
                                                  if (attendedQuiz[index]
                                                          ['correctAnswer'] ==
                                                      '3') {
                                                    correctAnswer += 1;
                                                  }
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                              margin:
                                                  const EdgeInsets.only(bottom: 15),
                                              decoration: BoxDecoration(
                                                  color: onSelect[index] == 3
                                                      ? attendedQuiz[index][
                                                                  'correctAnswer'] ==
                                                              '3'
                                                          ? Colors
                                                              .green.shade400
                                                          : Colors.red.shade400
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.15),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(
                                                'C) ${attendedQuiz[index]['option3']}',
                                                style: GoogleFonts.b612(
                                                    fontSize: 15.5),
                                              ),
                                            ),
                                          ),
                                        if (int.parse(attendedQuiz[index]
                                                ['optionCount']) >=
                                            4)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (onSelect[index] == 0) {
                                                  HapticFeedback.vibrate();
                                                  onSelect[index] = 4;
                                                  if (attendedQuiz[index]
                                                          ['correctAnswer'] ==
                                                      '4') {
                                                    correctAnswer += 1;
                                                  }
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                              margin:
                                                  const EdgeInsets.only(bottom: 15),
                                              decoration: BoxDecoration(
                                                  color: onSelect[index] == 4
                                                      ? attendedQuiz[index][
                                                                  'correctAnswer'] ==
                                                              '4'
                                                          ? Colors
                                                              .green.shade400
                                                          : Colors.red.shade400
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.15),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(
                                                'D) ${attendedQuiz[index]['option4']}',
                                                style: GoogleFonts.b612(
                                                    fontSize: 15.5),
                                              ),
                                            ),
                                          ),
                                        if (int.parse(attendedQuiz[index]
                                                ['optionCount']) >=
                                            5)
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (onSelect[index] == 0) {
                                                  HapticFeedback.vibrate();
                                                  onSelect[index] = 5;
                                                  if (attendedQuiz[index]
                                                          ['correctAnswer'] ==
                                                      '5') {
                                                    correctAnswer += 1;
                                                  }
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                              margin:
                                                  const EdgeInsets.only(bottom: 15),
                                              decoration: BoxDecoration(
                                                  color: onSelect[index] == 5
                                                      ? attendedQuiz[index][
                                                                  'correctAnswer'] ==
                                                              '5'
                                                          ? Colors
                                                              .green.shade400
                                                          : Colors.red.shade400
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(0.15),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(
                                                'E) ${attendedQuiz[index]['option5']}',
                                                style: GoogleFonts.b612(
                                                    fontSize: 15.5),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(10)),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                              .withOpacity(0.25),
                                          offset: const Offset(0, 0),
                                          blurRadius: 10,
                                          blurStyle: BlurStyle.normal)
                                    ]),
                                width: width(context),
                                height: 7.5,
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                Expanded(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller:
                          _pageViewController, // Link controller to PageView
                      count: attendedQuiz.length,
                      effect: ScrollingDotsEffect(
                          dotHeight: 10,
                          maxVisibleDots: 5,
                          activeDotColor:
                              Theme.of(context).colorScheme.secondary,
                          dotColor: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(.25)),
                      onDotClicked: (i) {},
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: (!onSelect.contains(0) && showScore),
                child: Container(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  width: width(context),
                  height: height(context),
                )),
            Visibility(
              visible: (!onSelect.contains(0) && showScore),
              child: Container(
                width: width(context),
                height: height(context) * 0.35,
                margin:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.125),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Your Score',
                      style: GoogleFonts.b612(
                          textStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.75),
                              fontSize: 20.5,
                              fontWeight: FontWeight.normal)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$correctAnswer/${attendedQuiz.length}',
                      style: GoogleFonts.b612(
                          textStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.75),
                              fontSize: 40.5,
                              fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if ((correctAnswer / attendedQuiz.length) * 100 <=
                                  100 &&
                              (correctAnswer / attendedQuiz.length) * 100 > 80)
                            DefaultTextStyle(
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.75),
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.normal)),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText('Perfect score!'),
                                  RotateAnimatedText('You aced it!'),
                                  RotateAnimatedText(
                                      'All your hard work truly paid off'),
                                ],
                              ),
                            ),
                          if ((correctAnswer / attendedQuiz.length) * 100 <=
                                  80 &&
                              (correctAnswer / attendedQuiz.length) * 100 > 60)
                            DefaultTextStyle(
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.75),
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.normal)),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText('Solid result!'),
                                  RotateAnimatedText('Great job!'),
                                  RotateAnimatedText(
                                      'You clearly grasped the key concepts'),
                                ],
                              ),
                            ),
                          if ((correctAnswer / attendedQuiz.length) * 100 <=
                                  60 &&
                              (correctAnswer / attendedQuiz.length) * 100 > 40)
                            DefaultTextStyle(
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.75),
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.normal)),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText('Needs review'),
                                  RotateAnimatedText(
                                      'Let\'s work together to improve'),
                                  RotateAnimatedText(
                                      'What areas can we focus on?'),
                                ],
                              ),
                            ),
                          if ((correctAnswer / attendedQuiz.length) * 100 <= 40)
                            DefaultTextStyle(
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.75),
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.normal)),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText('Below target'),
                                  RotateAnimatedText(
                                      'This score suggests some gaps in understanding'),
                                  RotateAnimatedText(
                                      'Let\'s revisit the material and practice more'),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Correct : ',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.75),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Text(
                              '$correctAnswer',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Colors.green.shade400,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Wrong : ',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.75),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Text(
                              '${attendedQuiz.length - correctAnswer}',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.normal)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _controllerCenter.stop();
                              DataHandler().attendQuiz(widget.title,
                                  '$correctAnswer/${attendedQuiz.length}');
                              DataHandler().addMyScore(
                                  '$correctAnswer/${attendedQuiz.length}',
                                  widget.attendQuizName,
                                  widget.taskUid);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()),
                              );
                            },
                            child: Text(
                              ' Home Page',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 12.5)),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _controllerCenter.stop();
                                showScore = false;
                              });
                            },
                            child: Text(
                              'View Score',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 12.5)),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: showScore,
              child: Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles:
                      5, // don't specify a direction, blast randomly
                  shouldLoop:
                      false, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
