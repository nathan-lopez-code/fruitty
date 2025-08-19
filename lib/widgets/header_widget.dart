// Créez un widget pour l'en-tête et les titres
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitty/utils/string_app.dart';
import 'package:fruitty/utils/utils.dart' show iconWidget;

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                StringApp.welcomeMessage,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 5),
              Text(
                StringApp.slogan,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              print("cool");
            },
            child: iconWidget(FontAwesomeIcons.heart, true),
          ),
        ],
      ),
    );
  }
}