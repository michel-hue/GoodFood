import 'package:flutter/material.dart';
import 'package:good_food/src/views/navigations/acceuil_page.dart';
import 'package:good_food/src/views/navigations/ajouter_page.dart';
import 'package:good_food/src/views/navigations/favoris_page.dart';
import 'package:good_food/src/widgets/bottomNavBar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController = PageController();

  int _selectedIndex = 0;

  final List<Widget> pages = [
    AcceuilPage(),
    AjouteRecettePage(),
    FavorisPage(),
  ];

  void _onItemsTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigatBar(
        currentIndex: _selectedIndex,
        onTap: _onItemsTapped,

      ),
    );
  }


  
}
