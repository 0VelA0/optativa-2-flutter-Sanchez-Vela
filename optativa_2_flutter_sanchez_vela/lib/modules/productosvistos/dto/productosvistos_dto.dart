class Productovistos {
  final String nombre;
  final double precio;
  int visitas;

  Productovistos({required this.nombre, required this.precio, this.visitas = 1});

  // Convertir el producto a un mapa para almacenarlo en shared_preferences
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'visitas': visitas,
    };
  }

  // Crear un producto desde un mapa
  factory Productovistos.fromMap(Map<String, dynamic> map) {
    return Productovistos(
      nombre: map['nombre'],
      precio: map['precio'],
      visitas: map['visitas'],
    );
  }
}
