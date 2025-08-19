import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


class Fruit {
  final String nom;
  final String image;
  final String description;
  final String avantages;
  final String categorie;
  final String couleur; // Le nouveau champ

  Fruit({
    required this.nom,
    required this.image,
    required this.description,
    required this.avantages,
    required this.categorie,
    required this.couleur, // Ajout du nouveau champ
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      nom: json['nom'],
      image: json['image'],
      description: json['description'],
      avantages: json['avantages'],
      categorie: json['categorie'],
      couleur: json['couleur'], // Extraction de la couleur
    );
  }
}

class FruitService {
  // Fonction asynchrone pour lire le fichier JSON
  static Future<List<Fruit>> loadFruits() async {
    // 1. Lire le fichier JSON en tant que chaîne de caractères
    final jsonString = await rootBundle.loadString('assets/data/fruits.json');

    // 2. Décoder la chaîne JSON en une liste dynamique
    final List<dynamic> jsonList = json.decode(jsonString);

    // 3. Convertir chaque élément de la liste en un objet Fruit
    return jsonList.map((json) => Fruit.fromJson(json)).toList();
  }
}