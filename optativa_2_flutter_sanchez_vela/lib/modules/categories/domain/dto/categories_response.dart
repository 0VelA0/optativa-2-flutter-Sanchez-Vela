class CategoryResponse {
  String slug;
  String name;
  String url;

  CategoryResponse({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }
}
