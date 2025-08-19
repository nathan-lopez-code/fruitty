import 'package:flutter/material.dart';
import '../services/fruits_services.dart';
import 'fruit_widget.dart';

class FruitGridView extends StatelessWidget {
  const FruitGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Fruit>>(
      future: FruitService.loadFruits(), // Appelle la méthode pour charger les fruits
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Affiche un indicateur de chargement
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}')); // Gère les erreurs
        } else if (snapshot.hasData) {
          // Les données sont chargées, on les passe à la grille
          final fruits = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 40,
            ),
            shrinkWrap: true,
            primary: false,
            itemCount: fruits.length, // Utilise la taille de la liste de fruits
            itemBuilder: (context, index) {
              final fruit = fruits[index]; // Récupère l'objet Fruit
              return FruitWidget(
                index: index,
                fruit: fruit, // Passe l'objet Fruit au widget de produit
              );
            },
          );
        } else {
          return const Center(child: Text('Aucun fruit trouvé.'));
        }
      },
    );
  }
}