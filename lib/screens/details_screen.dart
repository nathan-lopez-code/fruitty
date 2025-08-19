import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitty/utils/colors.dart';
import 'package:get/get.dart';
import 'package:fruitty/controllers/favorite_controller.dart';
import 'package:fruitty/services/fruits_services.dart';
import 'package:fruitty/utils/util_fonction.dart';
import 'package:fruitty/utils/utils.dart';

import '../utils/dimensions.dart';
import '../widgets/carte_info.dart';


class DetailsScreen extends StatefulWidget {
  final Fruit fruit;

  const DetailsScreen({
    super.key,
    required this.fruit,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [

          Container(
            height: size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            color: UtilFonction.fromHex(widget.fruit.couleur),
            child: Transform.rotate(
              angle: 2.10 * pi,
              child: Image.asset('assets/fruits/${widget.fruit.image}'),
            ),
          ),

          // Bouton de retour
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: size.height * 0.50,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: size.height * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.fruit.nom,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                  fontFamily: 'Poppins'),
                            ),

                            Text(
                              "Categorie : ${widget.fruit.nom}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),

                        Obx(
                              () {
                            final isFavorite = favoriteController.isFavorite(widget.fruit);
                            return ElevatedButton.icon(
                              onPressed: () {
                                favoriteController.toggleFavorite(widget.fruit);
                                Get.snackbar(
                                  'Favori mis à jour',
                                  isFavorite
                                      ? 'Retiré des favoris !'
                                      : 'Ajouté aux favoris !',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                              icon: Icon(
                                isFavorite
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              label: Text(
                                isFavorite ? 'Retirer' : 'Ajouter',
                                style: TextStyle(
                                  color: isFavorite ? Colors.red : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 2,
                      width: Dimensions.getScreenWidth(context),
                      decoration: BoxDecoration(
                        color: MeColors.kSecondaryColor
                      ),
                    ),
                    // product description
                    InfoCard(
                      title: "Avantages",
                      content: widget.fruit.avantages,
                      icon: FontAwesomeIcons.lightbulb,
                      cardColor: Colors.amber[50]!, // Une couleur de fond légère
                    ),

                    InfoCard(
                      title: "Détails",
                      content: widget.fruit.description,
                      icon: FontAwesomeIcons.circleInfo,
                      cardColor: Colors.blue[50]!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}