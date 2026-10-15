import 'package:flutter/material.dart';
import 'package:good_food/src/views/recette_page.dart';
import 'package:good_food/src/views/categorie_page.dart';
import 'package:good_food/src/views/detailsCard_page.dart';
import 'package:good_food/src/views/home_page.dart';
import 'package:good_food/src/views/navigations/acceuil_page.dart';
import 'package:good_food/src/views/navigations/ajouter_page.dart';
import 'package:good_food/src/views/navigations/favoris_page.dart';

class AppRoutes{

  static const String home= "/home";
  static const String acceuil= "/acceuil";
  static const String favoris= "/favoris";
  static const String ajouter= "/ajouter";
  static const String details = "/details";
  static const String categories = "/categories";
  static const String categorie = "/categorie";
  static const String recette = "/recette";



    static Map<String, WidgetBuilder> routes = {
      home: (context) => HomePage(),
      acceuil: (context) => AcceuilPage(),
      favoris: (context) => FavorisPage(),
      ajouter: (context) => AjouteRecettePage(),
      details: (context) => DetailsCards(),
      categories : (context) => CategoriePage(),
      //categorie : (context) => CategoriedetailsPage(),
      recette : (context) => RecettePage(),

    };

}