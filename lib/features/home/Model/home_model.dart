class HomeModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String type;
  final String model;

  HomeModel(
      {required this.id,
      required this.name,
      required this.slug,
      required this.description,
      required this.type,
      required this.model});

  factory HomeModel.fromJSON(Map<String, dynamic> json) {
    return HomeModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      type: json["type"],
      model: json["model"],
    );
  }
}
