class Category {
  final String name;
  final String icon;

  Category({
    required this.name,
    required this.icon,
  });

  // Aquí asignamos un icono basado en el nombre de la categoría
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
      icon: _getIconForCategory(json['name']),
    );
  }

  // Método para obtener un icono en base a la categoría
  static String _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'beauty':
        return 'assets/icons/beauty.png'; // Ruta de ejemplo
      case 'electronics':
        return 'assets/icons/electronics.png';
      // Agrega otros casos para cada categoría
      default:
        return 'assets/icons/default.png';
    }
  }
}

