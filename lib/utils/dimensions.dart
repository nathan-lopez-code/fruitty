import 'package:flutter/material.dart';

class Dimensions {

  // Méthode statique pour obtenir la largeur en pourcentage de l'écran
  static double getWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  // Méthode statique pour obtenir la hauteur en pourcentage de l'écran
  static double getHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  // Largeur de l'écran en entier
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Hauteur de l'écran en entier
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}