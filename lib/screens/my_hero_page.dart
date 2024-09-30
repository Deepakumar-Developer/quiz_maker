import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions.dart';
import 'my_gate_page.dart';

class MyHeroPage extends StatefulWidget {
  const MyHeroPage({super.key});

  @override
  State<MyHeroPage> createState() => _MyHeroPageState();
}

class _MyHeroPageState extends State<MyHeroPage> {
  bool showAppName = false;
  bool moveAppName = false;
  bool showLoader = false;
  bool showHideContainer = false;
  bool authAccountTitle = false;
  bool authAccountLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 750), () {
      setState(() {
        showAppName = true;
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          moveAppName = true;
        });
        Future.delayed(const Duration(milliseconds: 750), () {
          setState(() {
            showLoader = true;
          });

          Future.delayed(const Duration(milliseconds: 3000), () {
            setState(() {
              showHideContainer = true;
              if (FirebaseAuth.instance.currentUser?.uid == null) {
                authAccountLoader = true;
              } else {
                authAccountTitle = true;
              }
            });
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyGatePage()),
              );
            });
          });
        });
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
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutCubic,
                top: moveAppName ? 175 : height(context) * 0.35,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: showAppName ? 1 : 0,
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
              ),
              Positioned(
                bottom: 125,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 750),
                  opacity: showLoader ? 1 : 0,
                  child: SizedBox(
                    height: 100, // Adjust height as needed
                    child: Center(
                      child: SpinKitChasingDots(
                        color: Theme.of(context).colorScheme.secondary,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 125,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 750),
                  opacity: (authAccountTitle) ? 1 : 0,
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: width(context),
                    height: height(context),
                  ),
                ),
              ),
              Positioned(
                bottom: 115,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 750),
                  opacity: (showHideContainer && !authAccountLoader) ? 1 : 0,
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: width(context),
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
