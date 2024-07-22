import 'package:flutter/material.dart';

class Acercade extends StatelessWidget {
  final VoidCallback onVaciar;

  const Acercade({super.key, required this.onVaciar});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen de perfil
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const CircleAvatar(
                radius: 80, // Ajusta el tamaño del círculo según sea necesario
                backgroundImage: AssetImage(
                    'assets/yosoy.jpg'), // Verifica que la ruta sea correcta
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Yulian De Los Santos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                '2022-0592',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '"Las asociaciones hacen al hombre más fuerte y ponen de relieve las mejores dotes de las personas aisladas, y dan una alegría que raramente se alcanza actuando por cuenta propia."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ),
            // Deja un espacio flexible
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: onVaciar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Fondo rojo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Emergencia eliminar todo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
