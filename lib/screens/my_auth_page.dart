import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions.dart';
import 'my_gate_page.dart';

class MyAuthPage extends StatefulWidget {
  const MyAuthPage({super.key});

  @override
  State<MyAuthPage> createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  bool showButton = false;
  bool showLoader = false;
  bool showSetName = false;
  final userName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: 175,
                child: Column(
                  children: [
                    Text(
                      appName,
                      style: GoogleFonts.b612(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Make your own quiz',
                      style: GoogleFonts.b612(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 15,
                            wordSpacing: 5,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 125,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 750),
                  opacity: showButton ? 1 : 0,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width(context) * 0.75,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.75),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              color: Theme.of(context).colorScheme.surface,
                              child: Text(
                                'Create or Get account',
                                style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 7.5,
                                      wordSpacing: 2,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showLoader = true;
                            signIn();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
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
                          width: width(context) * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 40,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Create Account',
                                style: GoogleFonts.b612(
                                  textStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: showLoader || showSetName,
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
              Visibility(
                visible: showSetName,
                child: Container(
                  height: 225,
                  width: width(context) * 0.75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(17.5)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height(context) * 0.02,
                      ),
                      Text(
                        'Create Profile',
                        style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 30)),
                      ),
                      SizedBox(
                        height: height(context) * 0.02,
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          margin:
                              const EdgeInsets.only(top: 5, left: 35, right: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.tertiary,
                                weight: 10,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: userName,
                                  cursorColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ' Name...',
                                    hintStyle: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (userName.text.isNotEmpty) {
                                  DataHandler().setUserName(userName.text);
                                  showLoader = false;
                                  showSetName = false;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyGatePage()),
                                  );
                                } else {
                                  showToast('Enter the name', context);
                                }
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(
                                    top: 5, left: 5, right: 150, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(1),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.data_saver_on_rounded,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      weight: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Save',
                                      style: GoogleFonts.outfit(
                                          textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      )),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  signIn() {
    try {
      setState(() {
        Auth().anonymousUser();
        showSetName = true;
      });
    } on Exception catch (e) {
      showDialog(
          context: context,
          builder: (build) {
            return AlertDialog(
              alignment: Alignment.center,
              icon: const Icon(Icons.error_rounded),
              iconColor: Colors.red,
              title: Text(
                'oops! $e',
                textAlign: TextAlign.center,
                style: GoogleFonts.b612(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                      wordSpacing: 2,
                      letterSpacing: 1),
                ),
              ),
            );
          });
    }
  }
}
