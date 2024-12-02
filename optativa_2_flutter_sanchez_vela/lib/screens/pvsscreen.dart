import 'package:flutter/material.dart';
import '../modules/productosvistos/repository/productosvistos_service.dart';
import '../modules/productosvistos/dto/productosvistos_dto.dart';
import '../widgets/custom_appbar.dart';

class ProductosVistosScreen extends StatefulWidget {
  @override
  _ProductosVistosScreenState createState() => _ProductosVistosScreenState();
}

class _ProductosVistosScreenState extends State<ProductosVistosScreen> {
  late Future<List<Productovistos>> _productosVistos;

  @override
  void initState() {
    super.initState();
    _productosVistos = ProductosService.obtenerProductosVistos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Productos Vistos'),
      body: FutureBuilder<List<Productovistos>>(
        future: _productosVistos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los productos.'));
          }

          final productos = snapshot.data ?? [];
          if (productos.isEmpty) {
            return Center(child: Text('No hay productos vistos.'));
          }

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ListTile(
                title: Text(producto.nombre),
                subtitle: Text('Precio: \$${producto.precio.toStringAsFixed(2)} | Vistas: ${producto.visitas}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Lógica para agregar al carrito
                    Navigator.pushNamed(context, '/carritodecompras');
                  },
                  child: Text('Agregar'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
