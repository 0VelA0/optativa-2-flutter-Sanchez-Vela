class Category {
  final String name;
  final String createdAt;

  Category({required this.name, required this.createdAt});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
}
