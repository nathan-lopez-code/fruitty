import 'package:flutter/material.dart';
import 'package:fruitty/utils/colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/conseil_fruit.dart';


class ConseilsScreen extends StatefulWidget {
  const ConseilsScreen({super.key});

  @override
  State<ConseilsScreen> createState() => _ConseilsScreenState();
}

class _ConseilsScreenState extends State<ConseilsScreen> {

  static const _pageSize = 10;

  final PagingController<int, Conseil> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    // Initialisation du contrôleur
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // Appelle le service pour charger la page suivante
      final newItems = await ConseilService.loadConseils(pageKey, _pageSize);

      // Vérifie si c'est la dernière page
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        // Calcule le numéro de page suivant
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MeColors.kPrimaryColor,
        title: const Text(
            'Conseils sur les fruits',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
        ),
        centerTitle: true,
      ),
      body: PagedListView<int, Conseil>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Conseil>(
          itemBuilder: (context, conseil, index) {
            return _buildConseilCard(conseil);
          },
        ),
      ),
    );
  }

  Widget _buildConseilCard(Conseil conseil) {
    return Card(
      elevation: 4, // Ajoute une ombre
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icône d'ampoule
            const Icon(
              FontAwesomeIcons.solidLightbulb,
              color: Colors.amber,
              size: 30,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conseil.titre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE76F51),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    conseil.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}