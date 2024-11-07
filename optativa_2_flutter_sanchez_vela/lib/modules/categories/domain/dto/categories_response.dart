class Category {
  String name;
  String url;
  String slug;

  Category({
    required this.name,
    required this.url,
    required this.slug
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      url: json['imageUrl'] ?? '',
      slug: json['slug']
    );
  }
}
