import 'dart:convert';

import 'package:good_food/src/models/categorie_model.dart';
import 'package:good_food/src/models/recette_model.dart';
import 'package:http/http.dart' as http;

class RecetteServices {

  final String apiUrl = 'https://tasty.p.rapidapi.com';



  Future<List<CategorieModel>> getCategorie(List<CategorieModel> categories) async {

    final url = Uri.parse('$apiUrl/tags/list');

try{

    final res= await http.get(
      url,
     headers: {
    "X-RapidAPI-Key": "90fd88dbe8msh1d25279ff8b4789p1df9c4jsn3be69a339cf7",
    "X-RapidAPI-Host": "tasty.p.rapidapi.com",
    "Content-Type": "application/json",
    "Host": "tasty.p.rapidapi.com"
  }
    );

if (res.statusCode == 200) {
  final data = jsonDecode(res.body);
  final List results = data['results'] ?? []; 
  return results.map((item) => CategorieModel.fromJson(item)).toList();
} else {
  throw Exception('Erreur: ${res.statusCode}');
}

}catch(e){
  throw Exception('Erreur de l\'API : $e');
}

  }


  

  Future<List<RecetteModel>> getRecettes(List<RecetteModel> recettes) async {

//List<RecetteModel> recettes = [];
    final url = Uri.parse('$apiUrl/recipes/list?from=0&size=20&tags=under_30_minutes');

try{

    final res= await http.get(
      url,
     headers: {
    "X-RapidAPI-Key": "90fd88dbe8msh1d25279ff8b4789p1df9c4jsn3be69a339cf7",
    "X-RapidAPI-Host": "tasty.p.rapidapi.com",
    "Content-Type": "application/json",
    "Host": "tasty.p.rapidapi.com"
  }
    );

if (res.statusCode == 200) {
  final data = jsonDecode(res.body);
  final List results = data['results'] ?? []; 
  return results.map((item) => RecetteModel.fromJson(item)).toList();
} else {
  throw Exception('Erreur: ${res.statusCode}');
}

}catch(e){
  throw Exception('Erreur de l\'API : $e');
}
  }

}

