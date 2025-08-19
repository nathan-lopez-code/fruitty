import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/string_app.dart';
import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(AppConstant.URLMASTAGATE);
    if (!await launchUrl(url)) {
      throw Exception('Impossible de lancer $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringApp.welcomeMessage,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.1,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"
                ),
              ),
              Image.asset("assets/images/logo_fruitty.png", width: 140,),
              const SizedBox(height: 10),
              Text(
                StringApp.intro_decouverte,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",

                ),
              ),
              const SizedBox(height: 10),
              Text(
                StringApp.intro_descrition,
                style: TextStyle(
                  color: Colors.black54,
                  height: 1.4,
                  fontFamily: "Poppins",
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/introImage.png"),
              ),
              const Spacer(),
              Column(
                children: [
                  SlideAction(
                    borderRadius: 50,
                    outerColor: kPrimaryColor,
                    sliderButtonIcon: const Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 20,
                      color: kPrimaryColor,
                    ),
                    text: StringApp.swipe_start,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: "Poppins"
                    ),
                    onSubmit: () {
                      Timer(
                        const Duration(milliseconds: 100),
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text(
                          "DESIGN BY",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(width: 4,),
                        InkWell(
                          onTap: _launchUrl,
                          child: const Text(
                            AppConstant.BOITENAME,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

