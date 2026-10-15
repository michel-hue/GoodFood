import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_food/src/models/recette_model.dart';
import 'package:good_food/src/routes/routes.dart';
import 'package:good_food/src/services/recette_services.dart';
import 'package:good_food/src/themes/colors_theme.dart';

class RecettePage extends StatefulWidget {
  const RecettePage({super.key});

  @override
  State<RecettePage> createState() => _RecettePageState();
}

class _RecettePageState extends State<RecettePage> {
  List<RecetteModel> recettesList = [];

  Future<void> fetchRecettes() async {
    try {
      RecetteServices recetteService = RecetteServices();
      final data = await recetteService.getRecettes(recettesList);
      if (!mounted) return;
      setState(() {
        recettesList = data;
      });
    } catch (e) {
      debugPrint("Erreur actualités: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecettes();
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
        
        title: Text('Recettes', style: TextStyle(fontWeight: FontWeight.bold),),
        
 bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            height: 1.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primary.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),

            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recettesList.length,
                  itemBuilder: (context, index) {
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
            errorBuilder: (_, __, ___) => Container(
              height: 220.h,
              color: Colors.grey.shade200,
              child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Icon(Icons.share_outlined, size: 20.sp, color: Colors.white),
                    SizedBox(width: 10.w),
                    Icon(Icons.bookmark_add_outlined, size: 20.sp, color: Colors.white),
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
