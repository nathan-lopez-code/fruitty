// Créez un widget réutilisable pour la barre de recherche
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.getWidth(context, 85),
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Rechercher un fruit...',
          prefixIcon: const Icon(Icons.search, color: MeColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}