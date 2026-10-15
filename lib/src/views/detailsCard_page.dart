import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_food/src/models/recette_model.dart';
import 'package:good_food/src/themes/colors_theme.dart';

class DetailsCards extends StatefulWidget {
  const DetailsCards({super.key});

  @override
  State<DetailsCards> createState() => _DetailsCardsState();
}

class _DetailsCardsState extends State<DetailsCards> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final recette =
        ModalRoute.of(context)!.settings.arguments as RecetteModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      body: CustomScrollView(
        slivers: [
         
          SliverAppBar(
            expandedHeight: 320.h,
            pinned: true,
            backgroundColor: const Color(0xFFF8F5F0),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    size: 18, color: Colors.black87),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => setState(() => _isSaved = !_isSaved),
                child: Container(
                  margin: EdgeInsets.all(8.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
                    size: 20,
                    color: _isSaved ? AppColors.primary : Colors.black87,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(right: 12.w, top: 8, bottom: 8),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.share_outlined,
                      size: 20, color: Colors.black87),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.r)),
                child: Image.network(
                  recette.imageUrl,
                  fit: BoxFit.cover,
             
                ),
              ),
            ),
            
          ),

          // contenu
          SliverPadding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Titre du plat
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recette.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22.sp,
                              color: const Color(0xFF1A1A1A),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12.r,
                                backgroundColor: AppColors.primary,
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Chef Adrien Agreste',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Bouton ajouter à la liste
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 20),
                    label: Text(
                      'Ajouter à ma liste',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Description
                if (recette.description.isNotEmpty) ...[
                  _SectionTitle(title: 'Description'),
                  SizedBox(height: 10.h),
                  Text(
                    recette.description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                // Ingrédients
                _SectionTitle(
                  title: 'Ingrédients',
                  badge: '${recette.ingredients.length}',
                ),

                SizedBox(height: 10.h),

                recette.ingredients.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            'Aucun ingrédient disponible',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 13.sp),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recette.ingredients.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 3.5,
                        ),
                        itemBuilder: (context, index) {
                          return _IngredientChip(
                            name: recette.ingredients[index],
                            index: index,
                          );
                        },
                      ),

                SizedBox(height: 40.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}



class _SectionTitle extends StatelessWidget {
  final String title;
  final String? badge;

  const _SectionTitle({required this.title, this.badge});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        if (badge != null) ...[
          SizedBox(width: 8.w),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge!,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _IngredientChip extends StatelessWidget {
  final String name;
  final int index;

  const _IngredientChip({required this.name, required this.index});


  static const List<Color> _colors = [
    Color(0xFFFFEDD8),
    Color(0xFFDCFCE7),
    Color(0xFFE0F2FE),
    Color(0xFFFCE7F3),
    Color(0xFFFEF9C3),
    Color(0xFFEDE9FE),
  ];

  static const List<Color> _iconColors = [
    Color(0xFFEA580C),
    Color(0xFF16A34A),
    Color(0xFF0284C7),
    Color(0xFFDB2777),
    Color(0xFFCA8A04),
    Color(0xFF7C3AED),
  ];

  @override
  Widget build(BuildContext context) {
    final colorIndex = index % _colors.length;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: _colors[colorIndex],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: _iconColors[colorIndex],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}