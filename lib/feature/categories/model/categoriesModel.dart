class CategoriesModel {
  String slug;
  String name;
  String url;
  String image;

  CategoriesModel({
    required this.slug,
    required this.name,
    required this.url,
    required this.image,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "url": url,
    "image": image,
  };
}
