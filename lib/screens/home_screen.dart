import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:fruitty/screens/main_section.dart';
import 'package:fruitty/screens/tips_screen.dart';
import 'package:fruitty/utils/colors.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin {
  int _tabIndex = 1;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }
  late PageController pageController;

  void _update_index(int newIndex) {
    setState(() {
      tabIndex = newIndex;
    });
  }


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }
  Widget build(BuildContext context) {

    List<Widget> listSectionWidget = [
      ConseilsScreen(),
      MainSection(
        initialIndex : tabIndex,
        onChangeIndex : _update_index,
      ),
      FavoritesScreen()
    ];

    return Scaffold(
      body: SafeArea(
        child: listSectionWidget[tabIndex]
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        shadowColor: Colors.black26,
        foregroundColor: MeColors.kPrimaryColor,
        scrolledUnderElevation: 8.0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(top: 7, bottom: 10),
          child: Center(
            child: Image.asset("assets/images/logo_fruitty.png", width: 130, height: 130,),
          )
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: tabIndex,
        activeIcons: const [
          Icon(Icons.lightbulb_rounded, color: KSecondaryLightColor),
          Icon(Icons.home, color: KSecondaryLightColor),
          Icon(Icons.favorite, color: KSecondaryLightColor),
        ],
        inactiveIcons: const [
          Text("Tips", style: TextStyle(color: Colors.white, fontFamily: "Poppins"),),
          Text("Home", style: TextStyle(color: Colors.white, fontFamily: "Poppins")),
          Text("Favoris", style: TextStyle(color: Colors.white, fontFamily: "Poppins")),
        ],
        color: kPrimaryColor,
        height: 60,
        circleWidth: 60,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
