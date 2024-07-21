import 'package:flutter/material.dart';

class Acercade extends StatelessWidget {
  final VoidCallback onVaciar;

  Acercade({required this.onVaciar});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Imagen de perfil
          Container(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 80, // Ajusta el tamaño del círculo según sea necesario
              backgroundImage: AssetImage(
                  'assets/yosoy.jpg'), // Verifica que la ruta sea correcta
            ),
          ),
          SizedBox(height: 20),
          Center(
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
          SizedBox(height: 10),
          Center(
            child: Text(
              '2022-0592',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
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
          Spacer(), // Empuja el botón hacia el fondo
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: onVaciar,
              child: Row(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Fondo rojo del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
