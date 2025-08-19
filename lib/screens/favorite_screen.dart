import 'package:flutter/material.dart';
import 'package:fruitty/widgets/fruit_widget.dart';
import 'package:get/get.dart';
import 'package:fruitty/controllers/favorite_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "vos favoris",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(
                () {
              if (favoriteController.favoriteFruits.isEmpty) {
                return const Center(
                  child: Text('Aucun favori pour le moment.'),
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 40,
                ),
                padding: const EdgeInsets.all(16.0),
                itemCount: favoriteController.favoriteFruits.length,
                itemBuilder: (context, index) {
                  final fruit = favoriteController.favoriteFruits[index];
                  return FruitWidget(
                    index: index,
                    fruit: fruit,
                  );
                },
              );
            },
          ),
    );
  }
}