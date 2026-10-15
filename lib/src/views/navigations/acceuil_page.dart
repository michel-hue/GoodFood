import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_food/src/models/categorie_model.dart';
import 'package:good_food/src/models/recette_model.dart';
import 'package:good_food/src/routes/routes.dart';
import 'package:good_food/src/services/recette_services.dart';
import 'package:good_food/src/themes/colors_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> {

  bool isloading   = false;
  bool isFavori = false;

  TextEditingController controller = TextEditingController();

  List<RecetteModel> recettesList = [];
  List<CategorieModel> categorieList = [];


  //Recupérer les recettes
  Future<void> fetchRecettes() async {
    try {
      RecetteServices recetteService = RecetteServices();
      final data = await recetteService.getRecettes(recettesList);
      if (!mounted) return;
      setState(() {
        recettesList = data;
        isloading  = true;
      });
    } catch (e) {
      debugPrint("Erreur recettes: $e");
    }
  }

  //Récupérer les categorie de recette
  Future<void> fetchCategorie() async {
    try {
      RecetteServices recetteService = RecetteServices();
      final data = await recetteService.getCategorie(categorieList);
      if (!mounted) return;
      setState(() {
        categorieList = data;
        isloading = true;
      });
    } catch (e) {
      debugPrint("Erreur categories: $e");
    }
  }


  //Enregistrer une recette en favoris
  Future<void> ajouterFavori(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favoris = prefs.getStringList("favoris") ?? [];

    if (!favoris.contains(id)) {
      favoris.add(id);
    }

    setState(() {
      isFavori = isFavori;
    });

    await prefs.setStringList("favoris", favoris);
  }


  //Retirer une recette en favoris
  Future<void> retirerFavori(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favoris = prefs.getStringList("favoris") ?? [];

    favoris.remove(id);
    setState(() {
      isFavori = true;
    });

    await prefs.setStringList("favoris", favoris);
  }

/*
  static bool isFavori(String id) {
    List<String> favoris = getStringList("favoris");
    return favoris.contains(id);
  }


  static Future<void> toggleFavori(String id) async {
    List<String> favoris = getStringList("favoris");

    if (favoris.contains(id)) {
      favoris.remove(id);
    } else {
      favoris.add(id);
    }

    await setStringList("favoris", favoris);
  }*/

  @override
  void initState() {
    super.initState();
    fetchRecettes();
    fetchCategorie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: TextField(
                            controller: controller,
                            style: TextStyle(fontSize: 13.sp),
                            decoration: InputDecoration(
                              hintText: "Rechercher une recette...",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.grey.shade400,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14.h,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Container(
                        height: 48.h,
                        width: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.primary,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Categories',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.categories);
                        },
                        label: Row(
                          children: [
                            Text(
                              'Plus',
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.deepOrange,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  SizedBox(
                    height: 42.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: !isloading ? 5 : categorieList.length.clamp(0, 5),
                      itemBuilder: (context, index) {
                        if (!isloading) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 90.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                            ),
                          );
                        }
                         else{
                        final categorie = categorieList[index];

                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.categorie,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? AppColors.primary
                                    : AppColors.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  categorie.displayName,
                                  style: TextStyle(
                                    color: index == 0
                                        ? Colors.white
                                        : AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        }
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.primary,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Recette populaire',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.recette);
                        },
                        label: Row(
                          children: [
                            Text(
                              'Plus',
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.deepOrange,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                   // itemCount: recettesList.length.clamp(0, 4),

                    itemCount: !isloading ? 4 : recettesList.length.clamp(0, 4),
// 4 items sh
                    itemBuilder: (context, index) {

    // Shimmer card recette
    if (!isloading) {
    return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Stack(
    children: [
    // Bloc image simulé
    Container(
    width: double.infinity,
    height: 220.h,
    color: Colors.white,
    ),

    // Dégradé simulé en bas
    Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
    height: 80.h,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    Colors.transparent,
    Colors.grey.shade400,
    ],
    ),
    ),
    ),
    ),

    // Titre simulé
    Positioned(
    bottom: 14.h,
    left: 14.w,
    right: 14.w,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    // Barre titre
    Container(
    width: 140.w,
    height: 14.h,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(6.r),
    ),
    ),

    // Icônes simulées
    Row(
    children: [
    Container(
    width: 20.w,
    height: 20.h,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4.r),
    ),
    ),
    SizedBox(width: 10.w),
    Container(
    width: 20.w,
    height: 20.h,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4.r),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    );
                      } else {
                        final recette = recettesList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.details,
                              arguments: recette,
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Stack(
                                children: [
                                  // Image
                                  Image.network(
                                    recette.imageUrl,
                                    width: double.infinity,
                                    height: 220.h,
                                    fit: BoxFit.cover,
                                  ),

                                  // Dégradé sombre en bas
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.65),
                                          ],
                                          stops: const [0.5, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // nom et icon
                                  Positioned(
                                    bottom: 14.h,
                                    left: 14.w,
                                    right: 14.w,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            recette.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon:
                                             Icon(Icons.share_outlined,
                                               size: 20.sp,
                                               color: Colors.white,)
                                            ),
                                            SizedBox(width: 10.w),
                                            IconButton(
                                              onPressed: (){
                                                if(isFavori){
                                                  ajouterFavori(recette.id);
                                                } else{
                                                  retirerFavori(recette.id);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.bookmark_add_outlined,
                                                size: 20.sp,
                                                color: Colors.white,)

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
