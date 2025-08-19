import 'package:get/get.dart';
import '../services/fruits_services.dart';

class FavoriteController extends GetxController {
  var favoriteFruits = <Fruit>[].obs;

  void toggleFavorite(Fruit fruit) {
    if (isFavorite(fruit)) {
      favoriteFruits.removeWhere((fav) => fav.nom == fruit.nom);
    } else {
      favoriteFruits.add(fruit);
    }
    update();
  }

  bool isFavorite(Fruit fruit) {
    return favoriteFruits.any((fav) => fav.nom == fruit.nom);
  }
}