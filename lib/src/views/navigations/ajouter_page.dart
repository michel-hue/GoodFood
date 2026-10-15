import 'package:flutter/material.dart';
import 'package:good_food/src/themes/colors_theme.dart';
import 'package:good_food/src/widgets/ajouter_widget.dart';

class AjouteRecettePage extends StatefulWidget {
  const AjouteRecettePage({super.key});

  @override
  State<AjouteRecettePage> createState() => _AjouteRecettePageState();
}

class _AjouteRecettePageState extends State<AjouteRecettePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
  centerTitle: false, 
  title: Row(
    mainAxisSize: MainAxisSize.min, 
    children: [
      Container(
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.primary, width: 3),
          ),
        ),
      ),
      SizedBox(width: 10),
      Text(
        'Ajouter une Recette',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Roboto Condensed", 
        ),
      ),
    ],
  ),
),
   body: SafeArea(
  child: SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 350),
    child: SizedBox(
      width: double.infinity,  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(  
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
              context: context, 
                    backgroundColor: Colors.transparent,
            isScrollControlled: true,
              builder: (context) => AjouterRecette(),
              );
            },
            icon: Icon(Icons.add_circle),
            label: Text('Ajouter une recette'),
          ),
        ],
      ),
    ),
  ),
),
    
    );
  }
}