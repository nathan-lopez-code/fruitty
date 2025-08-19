import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitty/widgets/fruit_widget.dart';
import 'package:get/get.dart';

import '../services/fruits_services.dart';
import '../utils/colors.dart';
import '../utils/string_app.dart';
import '../utils/utils.dart';
import 'details_screen.dart';
import 'favorite_screen.dart';

class MainSection extends StatefulWidget {
  final int initialIndex;
  final Function(int) onChangeIndex;
  const MainSection({super.key, required this.initialIndex, required this.onChangeIndex });

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  // Liste complète de tous les fruits
  List<Fruit> allFruits = [];
  // Liste des fruits qui seront affichés (filtrée)
  List<Fruit> filteredFruits = [];
  // Index de la catégorie actuellement sélectionnée
  int selectedCategoryIndex = 0;
  // Liste des noms de catégories
  List<String> categories = ['Tous'];

  @override
  void initState() {
    super.initState();
    _loadAllFruits();
  }


  Future<void> _loadAllFruits() async {
    final fruits = await FruitService.loadFruits();

    final uniqueCategories = fruits.map((f) => f.categorie).toSet().toList();

    setState(() {
      allFruits = fruits;
      categories.addAll(uniqueCategories);
      _filterFruitsByCategory(0);
    });
  }

  void _filterFruitsByCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      if (index == 0) {
        filteredFruits = allFruits;
      } else {
        final categoryName = categories[index];
        filteredFruits =
            allFruits.where((fruit) => fruit.categorie == categoryName).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 5),
                  Text(
                    StringApp.slogan,
                    maxLines: 5,
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
                  setState(() {
                    widget.onChangeIndex(2);
                  });
                },
                child: iconWidget(FontAwesomeIcons.heart, false),
              ),
            ],
          ),


          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              padding: const EdgeInsets.only(top: 20.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _filterFruitsByCategory(index),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: index == selectedCategoryIndex
                            ? kPrimaryColor
                            : Colors.black45,
                        fontWeight: index == selectedCategoryIndex
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),


          if (allFruits.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (filteredFruits.isEmpty)
            const Center(child: Text('Aucun fruit dans cette catégorie'))
          else
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 40,
              ),
              shrinkWrap: true,
              primary: false,
              itemCount: filteredFruits.length,
              itemBuilder: (context, index) {
                final fruit = filteredFruits[index];
                return FruitWidget(
                  index: index,
                  fruit: fruit,
                );
              },
            ),
        ],
      ),
    );
  }
}