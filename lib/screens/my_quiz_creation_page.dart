import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_maker/functions.dart';
import 'package:quiz_maker/screens/my_home_page.dart';

class MyQuizCreationPage extends StatefulWidget {
  final bool update;
  const MyQuizCreationPage({super.key, required this.update});

  @override
  State<MyQuizCreationPage> createState() => _MyQuizCreationPageState();
}

class _MyQuizCreationPageState extends State<MyQuizCreationPage> {
  var quizQuestion = TextEditingController();
  var quizOption1 = TextEditingController();
  var quizOption2 = TextEditingController();
  var quizOption3 = TextEditingController();
  var quizOption4 = TextEditingController();
  var quizOption5 = TextEditingController();
  List<String> options = ['2', '3', '4', '5'];
  List<List<String>> correctOption = [
    [],
    [],
    ['1', '2'],
    ['1', '2', '3'],
    ['1', '2', '3', '4'],
    ['1', '2', '3', '4', '5']
  ];
  String currentOption = '4';
  String correctAnswer = '1';
  bool showLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.update) {
      quizQuestion = TextEditingController(text: createQuiz[0]['question']);
      if (int.parse(createQuiz[0]['optionCount']) >= 1) {
        quizOption1 = TextEditingController(text: createQuiz[0]['option1']);
      }
      if (int.parse(createQuiz[0]['optionCount']) >= 2) {
        quizOption2 = TextEditingController(text: createQuiz[0]['option2']);
      }
      if (int.parse(createQuiz[0]['optionCount']) >= 3) {
        quizOption3 = TextEditingController(text: createQuiz[0]['option3']);
      }
      if (int.parse(createQuiz[0]['optionCount']) >= 4) {
        quizOption4 = TextEditingController(text: createQuiz[0]['option4']);
      }
      if (int.parse(createQuiz[0]['optionCount']) >= 5) {
        quizOption5 = TextEditingController(text: createQuiz[0]['option5']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          quizName,
          style: GoogleFonts.b612(
              textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5)),
        ),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              quizQuestion.clear();
              quizOption1.clear();
              quizOption2.clear();
              quizOption3.clear();
              quizOption4.clear();
              quizOption5.clear();
              quizName = '';
              createQuiz = [
                {
                  'question': 'what is your name',
                  'optionCount': '5',
                  'correctAnswer': '1',
                  'option1': 'deepak',
                  'option2': 'kumar',
                  'option3': 'sri',
                  'option4': 'man',
                },
              ];
            });
            index = 0;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (createQuiz.length > 1) {
                setState(() {
                  showLoader = true;
                  if (currentOption.isNotEmpty) {
                    int parsedOptionCount = int.parse(currentOption);
                    createQuiz[index] = {
                      'question': quizQuestion.text.toString().trim(),
                      'optionCount': parsedOptionCount.toString(),
                      'correctAnswer': correctAnswer,
                      'option1': quizOption1.text.isEmpty
                          ? quizQuestion.text.isEmpty? '':'Empty Option '
                          : quizOption1.text.toString().trim(),
                      'option2': quizOption2.text.isEmpty
                          ? quizQuestion.text.isEmpty? '':'Empty Option '
                          : quizOption2.text.toString().trim(),
                    };
                    if (parsedOptionCount >= 3) {
                      createQuiz[index]['option3'] = quizOption3.text.isEmpty
                          ? quizQuestion.text.isEmpty? '':'Empty Option '
                          : quizOption3.text.toString().trim();
                    }
                    if (parsedOptionCount >= 4) {
                      createQuiz[index]['option4'] = quizOption4.text.isEmpty
                          ? quizQuestion.text.isEmpty? '':'Empty Option '
                          : quizOption4.text.toString().trim();
                    }
                    if (parsedOptionCount >= 5) {
                      createQuiz[index]['option5'] = quizOption5.text.isEmpty
                          ? quizQuestion.text.isEmpty? '':'Empty Option '
                          : quizOption5.text.toString().trim();
                    }
                  } else {
                    // Handle the case where currentOption is invalid or empty
                    showToast('Invalid option count', context);
                    return;
                  }
                  // print(createQuiz);
                  DataHandler().buildQuiz(context);
                  createQuiz = [
                    {
                      'question': 'what is your name',
                      'optionCount': '5',
                      'correctAnswer': '1',
                      'option1': 'deepak',
                      'option2': 'kumar',
                      'option3': 'sri',
                      'option4': 'man',
                    },
                  ];
                  Future.delayed(const Duration(milliseconds: 2500), () {
                    showLoader = false;
                  });
                  index = 0;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                });
              } else {
                showToast('First create the Quiz', context);
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  color: Theme.of(context).colorScheme.secondary),
              width: 125,
              height: 45,
              child: Text(
                'Create',
                style: GoogleFonts.b612(
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: width(context),
            height: height(context),
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      color: Theme.of(context).colorScheme.secondary,
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
                SizedBox(
                    width: width(context),
                    height: height(context) * 0.725,
                    child: Container(
                      width: width(context),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Text(
                                '${index + 1}',
                                style: GoogleFonts.b612(
                                    textStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                width: width(context) * 0.745,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(1),
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
                                  controller: quizQuestion,
                                  cursorColor:
                                      Theme.of(context).colorScheme.secondary,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 2,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: 'Quiz Question...',
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
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.75),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  DropdownButton<String>(
                                    value:
                                        correctAnswer, // Currently selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        correctAnswer = newValue!;
                                      });
                                    },
                                    items:
                                        correctOption[int.parse(currentOption)]
                                            .map((option) => DropdownMenuItem(
                                                  value: option,
                                                  child: Text(option),
                                                ))
                                            .toList(),
                                  ),
                                  Text(
                                    'Correct Answer',
                                    style: GoogleFonts.b612(
                                        textStyle: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            letterSpacing: 1)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  DropdownButton<String>(
                                    value:
                                        currentOption, // Currently selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        currentOption = newValue!;
                                      });
                                    },
                                    items: options
                                        .map((option) => DropdownMenuItem(
                                              value: option,
                                              child: Text(option),
                                            ))
                                        .toList(),
                                  ),
                                  Text(
                                    'Options',
                                    style: GoogleFonts.b612(
                                        textStyle: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            letterSpacing: 1)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: (1 <= int.parse(currentOption)),
                            child: Row(
                              children: [
                                Text(
                                  'A)',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          letterSpacing: 1)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  width: width(context) * 0.76,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
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
                                    controller: quizOption1,
                                    cursorColor:
                                        Theme.of(context).colorScheme.secondary,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Option 1',
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: (2 <= int.parse(currentOption)),
                            child: Row(
                              children: [
                                Text(
                                  'B)',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          letterSpacing: 1)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  width: width(context) * 0.76,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
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
                                    controller: quizOption2,
                                    cursorColor:
                                        Theme.of(context).colorScheme.secondary,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Option 2',
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: (3 <= int.parse(currentOption)),
                            child: Row(
                              children: [
                                Text(
                                  'C)',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          letterSpacing: 1)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  width: width(context) * 0.76,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
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
                                    controller: quizOption3,
                                    cursorColor:
                                        Theme.of(context).colorScheme.secondary,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Option 3',
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: (4 <= int.parse(currentOption)),
                            child: Row(
                              children: [
                                Text(
                                  'D)',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          letterSpacing: 1)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  width: width(context) * 0.76,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
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
                                    controller: quizOption4,
                                    cursorColor:
                                        Theme.of(context).colorScheme.secondary,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Option 4',
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: (5 <= int.parse(currentOption)),
                            child: Row(
                              children: [
                                Text(
                                  'E)',
                                  style: GoogleFonts.b612(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          letterSpacing: 1)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  width: width(context) * 0.76,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1),
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
                                    controller: quizOption5,
                                    cursorColor:
                                        Theme.of(context).colorScheme.secondary,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Option 5',
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(bottom: Radius.circular(10)),
                      color: Theme.of(context).colorScheme.secondary,
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: (index != 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (currentOption.isNotEmpty) {
                              int parsedOptionCount = int.parse(currentOption);
                              createQuiz[index] = {
                                'question': quizQuestion.text.toString().trim(),
                                'optionCount': parsedOptionCount.toString(),
                                'correctAnswer': correctAnswer,
                                'option1': quizOption1.text.isEmpty
                                    ? quizQuestion.text.isEmpty
                                        ? ''
                                        : 'Empty Option '
                                    : quizOption1.text.toString().trim(),
                                'option2': quizOption2.text.isEmpty
                                    ? quizQuestion.text.isEmpty
                                        ? ''
                                        : 'Empty Option '
                                    : quizOption2.text.toString().trim(),
                              };
                              if (parsedOptionCount >= 3) {
                                createQuiz[index]['option3'] =
                                    quizOption3.text.isEmpty
                                        ? quizQuestion.text.isEmpty
                                            ? ''
                                            : 'Empty Option '
                                        : quizOption3.text.toString().trim();
                              }
                              if (parsedOptionCount >= 4) {
                                createQuiz[index]['option4'] =
                                    quizOption4.text.isEmpty
                                        ? quizQuestion.text.isEmpty
                                            ? ''
                                            : 'Empty Option '
                                        : quizOption4.text.toString().trim();
                              }
                              if (parsedOptionCount >= 5) {
                                createQuiz[index]['option5'] =
                                    quizOption5.text.isEmpty
                                        ? quizQuestion.text.isEmpty
                                            ? ''
                                            : 'Empty Option '
                                        : quizOption5.text.toString().trim();
                              }
                            } else {
                              // Handle the case where currentOption is invalid or empty
                              showToast('Invalid option count', context);
                              return;
                            }
                            index -= 1;
                            currentOption = createQuiz[index]['optionCount']!;
                            correctAnswer = createQuiz[index]['correctAnswer']!;
                            quizQuestion = TextEditingController(
                                text: createQuiz[index]['question']);
                            if (1 <=
                                int.parse(createQuiz[index]['optionCount']!)) {
                              quizOption1 = TextEditingController(
                                  text: createQuiz[index]['option1']);
                            }
                            if (2 <=
                                int.parse(createQuiz[index]['optionCount']!)) {
                              quizOption2 = TextEditingController(
                                  text: createQuiz[index]['option2']);
                            }
                            if (3 <=
                                int.parse(createQuiz[index]['optionCount']!)) {
                              quizOption3 = TextEditingController(
                                  text: createQuiz[index]['option3']);
                            }
                            if (4 <=
                                int.parse(createQuiz[index]['optionCount']!)) {
                              quizOption4 = TextEditingController(
                                  text: createQuiz[index]['option4']);
                            }
                            if (5 <=
                                int.parse(createQuiz[index]['optionCount']!)) {
                              quizOption5 = TextEditingController(
                                  text: createQuiz[index]['option5']);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).colorScheme.secondary),
                          width: 125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Previous',
                                style: GoogleFonts.b612(
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (quizQuestion.text.isNotEmpty) {
                          setState(() {
                            createQuiz.add(
                              {
                                'question': '',
                                'optionCount': currentOption,
                                'correctAnswer': '1',
                                'option1': '',
                                'option2': '',
                                'option3': '',
                                'option4': '',
                              },
                            );

                            // Ensure currentOption is a valid integer before parsing
                            if (currentOption.isNotEmpty) {
                              int parsedOptionCount = int.parse(currentOption);
                              createQuiz[index] = {
                                'question': quizQuestion.text.toString().trim(),
                                'optionCount': parsedOptionCount.toString(),
                                'correctAnswer': correctAnswer,
                                'option1': quizOption1.text.isEmpty
                                    ? quizQuestion.text.isEmpty
                                        ? ''
                                        : 'Empty Option '
                                    : quizOption1.text.toString().trim(),
                                'option2': quizOption2.text.isEmpty
                                    ? quizQuestion.text.isEmpty
                                        ? ''
                                        : 'Empty Option '
                                    : quizOption2.text.toString().trim(),
                              };
                              if (parsedOptionCount >= 3) {
                                createQuiz[index]['option3'] =
                                    quizOption3.text.isEmpty
                                        ? quizQuestion.text.isEmpty
                                            ? ''
                                            : 'Empty Option '
                                        : quizOption3.text.toString().trim();
                              }
                              if (parsedOptionCount >= 4) {
                                createQuiz[index]['option4'] =
                                    quizOption4.text.isEmpty
                                        ? quizQuestion.text.isEmpty
                                            ? ''
                                            : 'Empty Option '
                                        : quizOption4.text.toString().trim();
                              }
                              if (parsedOptionCount >= 5) {
                                createQuiz[index]['option5'] =
                                    quizOption5.text.isEmpty
                                        ? quizQuestion.text.isEmpty
                                            ? ''
                                            : 'Empty Option '
                                        : quizOption5.text.toString().trim();
                              }
                            } else {
                              // Handle the case where currentOption is invalid or empty
                              showToast('Invalid option count', context);
                              return;
                            }

                            index += 1;
                            if (index <= createQuiz.length) {
                              quizQuestion = TextEditingController(
                                  text: createQuiz[index]['question']);
                              correctAnswer =
                                  createQuiz[index]['correctAnswer']!;
                              currentOption =
                                  createQuiz[index]['optionCount'] ?? '1';

                              if (1 <=
                                  int.parse(
                                      createQuiz[index]['optionCount']!)) {
                                quizOption1 = TextEditingController(
                                    text: createQuiz[index]['option1']);
                              }
                              if (2 <=
                                  int.parse(
                                      createQuiz[index]['optionCount']!)) {
                                quizOption2 = TextEditingController(
                                    text: createQuiz[index]['option2']);
                              }
                              if (3 <=
                                  int.parse(
                                      createQuiz[index]['optionCount']!)) {
                                quizOption3 = TextEditingController(
                                    text: createQuiz[index]['option3']);
                              }
                              if (4 <=
                                  int.parse(
                                      createQuiz[index]['optionCount']!)) {
                                quizOption4 = TextEditingController(
                                    text: createQuiz[index]['option4']);
                              }
                              if (5 <=
                                  int.parse(
                                      createQuiz[index]['optionCount']!)) {
                                quizOption5 = TextEditingController(
                                    text: createQuiz[index]['option5']);
                              }
                            } else {
                              quizQuestion.clear();
                              quizOption1.clear();
                              quizOption2.clear();
                              quizOption3.clear();
                              quizOption4.clear();
                              quizOption5.clear();
                            }
                          });
                        } else {
                          showToast('Create Task', context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            color: Theme.of(context).colorScheme.secondary),
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Visibility(
              visible: showLoader,
              child: Container(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
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
    );
  }
}
