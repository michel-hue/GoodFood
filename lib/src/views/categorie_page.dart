import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_food/src/models/categorie_model.dart';
import 'package:good_food/src/services/recette_services.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  List<CategorieModel> categorieList = [];

  Future<void> fetchCategorie() async {
    try {
      RecetteServices recetteService = RecetteServices();
      final data = await recetteService.getCategorie(categorieList);
      if (!mounted) return;
      setState(() {
        categorieList = data;
      });
    } catch (e) {
      debugPrint("Erreur categories: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategorie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Categories'),
      ),

      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categorieList.length,
                  itemBuilder: (context, index) {
                    final categorie = categorieList[index];

                    return ListTile(
                      title: Text(categorie.name),
                      subtitle: Text('ID: ${categorie.id}'),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
