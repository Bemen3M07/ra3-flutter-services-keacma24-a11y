import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../car_provider.dart';

class CarScreen extends StatefulWidget {
  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  void initState() {
    super.initState();
    // Ejecutamos la carga de datos al iniciar la pantalla
    Future.microtask(() => context.read<CarProvider>().fetchCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de Coches')),
      body: Consumer<CarProvider>( // El Consumer detecta los cambios del Provider
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.cars.length,
            itemBuilder: (context, index) {
              final car = provider.cars[index];
              return ListTile(
                leading: const Icon(Icons.directions_car),
                title: Text('${car.make} ${car.model}'),
                subtitle: Text('Año: ${car.year} | Tipo: ${car.type}'),
              );
            },
          );
        },
      ),
    );
  }
}