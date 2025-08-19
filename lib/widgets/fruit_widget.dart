import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitty/utils/colors.dart';
import 'package:fruitty/utils/utils.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../screens/details_screen.dart';
import '../services/fruits_services.dart';
import '../utils/util_fonction.dart';

class FruitWidget extends StatelessWidget {
  final Fruit fruit;
  final int index;
  const FruitWidget({super.key, required this.fruit, required this.index});



  @override
  Widget build(BuildContext context) {

    final FavoriteController favoriteController = Get.find();

    return Container(
      color: UtilFonction.fromHex(fruit.couleur),
      child: Stack(
        children: [
          // image of product
          Align(
            alignment: Alignment.topCenter,
            child: Transform.rotate(
              angle: 2.05 * pi,
              child: Image.asset(
                "assets/fruits/${fruit.image}",
                height: 120,
              ),
            ),
          ),

          // heart icon
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: UtilFonction.fromHex(fruit.couleur),
                shape: BoxShape.circle,
                boxShadow: boxShadow,
              ),
              child: Obx(
                    () {
                  final isFavorite = favoriteController.isFavorite(fruit);
                  return Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        // Appelle la méthode pour ajouter/retirer des favoris
                        favoriteController.toggleFavorite(fruit);
                      },
                      icon: Icon(
                        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              ),
            ),
          // product details
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    fruit: fruit, // Passe l'objet Fruit à l'écran de détails
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                    Get.to(() => DetailsScreen(fruit: fruit));
                },
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      // product based box shadow
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fruit.nom,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: "Poppins"
                        ),
                      ),

                      Row(
                        children:  [
                          Text(
                            fruit.categorie,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
