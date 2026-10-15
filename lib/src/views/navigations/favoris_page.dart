import 'package:flutter/material.dart';

import '../../themes/colors_theme.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
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
            'Mes recettes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto Condensed",
            ),
          ),
        ],
      ),
    ),
    );
  }
}