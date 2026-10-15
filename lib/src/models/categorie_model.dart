class CategorieModel {
  final int id;        
  final String name;  
  final String displayName;

  CategorieModel({
    required this.id,
    required this.name,
    required this.displayName,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
      id: json['id'],
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
    );
  }
}
