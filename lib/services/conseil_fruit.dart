import 'dart:convert';

import 'package:flutter/services.dart';

class Conseil {
  final String titre;
  final String description;

  Conseil({required this.titre, required this.description});

  factory Conseil.fromJson(Map<String, dynamic> json) {
    return Conseil(
      titre: json['titre'],
      description: json['description'],
    );
  }
}



class ConseilService {
  // Une fonction qui charge les conseils par page
  static Future<List<Conseil>> loadConseils(int pageKey, int pageSize) async {
    final jsonString = await rootBundle.loadString('assets/data/conseils_fruits.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    // Simulation de la pagination :
    // Calcul de l'index de départ
    final startIndex = pageKey;
    // Calcul de l'index de fin
    final endIndex = (startIndex + pageSize) > jsonList.length
        ? jsonList.length
        : startIndex + pageSize;

    // Récupération du sous-ensemble de données pour la page actuelle
    final paginatedList = jsonList.sublist(startIndex, endIndex);

    // Ajout d'un petit délai pour simuler une requête réseau
    await Future.delayed(const Duration(milliseconds: 500));

    return paginatedList.map((json) => Conseil.fromJson(json)).toList();
  }
}