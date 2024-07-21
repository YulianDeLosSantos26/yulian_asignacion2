import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'boton.dart';
import 'package:dotted_border/dotted_border.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController Fechacontroller;
  final TextEditingController controller;
  final TextEditingController Descripcioncontroller;

  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onArchivoImagen;
  final VoidCallback onArchivoAudio;

  DialogBox({
    super.key,
    required this.Fechacontroller,
    required this.controller,
    required this.Descripcioncontroller,
    required this.onSave,
    required this.onCancel,
    required this.onArchivoImagen,
    required this.onArchivoAudio,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Color de fondo corregido
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: Fechacontroller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Fecha',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
              controller: controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
              maxLength: 65,
              controller: Descripcioncontroller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descripción',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            GestureDetector(
              onTap: onArchivoImagen,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 133, 192, 23),
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Buscar Imagen',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 233, 230, 230)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onArchivoAudio,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Color.fromARGB(255, 133, 192, 23),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 175, 173, 36),
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Seleccionar Audio',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 233, 230, 230)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(onPressed: onSave, text: 'Guardar'),
                MyButton(onPressed: onCancel, text: 'Cancelar'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
