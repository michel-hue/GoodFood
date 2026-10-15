class RecetteModel {
  final int id;                
  final String name;           
  final String description;     
  final String imageUrl;       
  final List<String> ingredients;

  RecetteModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
  });

  factory RecetteModel.fromJson(Map<String, dynamic> json) {
    return RecetteModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['thumbnail_url'] ?? '',
ingredients: (json['sections'] as List<dynamic>?)
    ?.isNotEmpty == true
    ? ((json['sections'][0]['components'] as List<dynamic>?)
        ?.map((item) => item['ingredient']?['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList() ?? [])
    : [],
    );
  }
}
