import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_food/src/themes/colors_theme.dart';

class AjouterRecette extends StatefulWidget {
  const AjouterRecette({super.key});

  @override
  State<AjouterRecette> createState() => _AjouterRecetteState();
}

class _AjouterRecetteState extends State<AjouterRecette> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: EdgeInsets.only(left: 50, right: 50, top: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Colors.white24, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        top: false,

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Column(
                children: [
                  Text(
                    'Ajouter une Recette',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto Condensed",
                    ),
                  ),

                  Text(
                    'ajout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto Condensed",
                      color: AppColors.primary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
