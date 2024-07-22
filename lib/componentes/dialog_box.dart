import 'package:flutter/material.dart';
import 'boton.dart';
import 'package:dotted_border/dotted_border.dart';

class DialogBox extends StatefulWidget {
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
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  bool _imagenSeleccionada = false;
  bool _audioSeleccionado = false;

  void _handleImagenSelection() {
    widget.onArchivoImagen();
    setState(() {
      _imagenSeleccionada = true;
    });
  }

  void _handleAudioSelection() {
    widget.onArchivoAudio();
    setState(() {
      _audioSeleccionado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: widget.Fechacontroller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
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
              controller: widget.controller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
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
              maxLength: 75,
              controller: widget.Descripcioncontroller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
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
              onTap: _handleImagenSelection,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _imagenSeleccionada
                          ? Colors.green
                          : const Color.fromARGB(255, 133, 192, 23),
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        const Center(
                          child: Text(
                            'Buscar Imagen',
                            style: TextStyle(
                                color: Color.fromARGB(255, 233, 230, 230)),
                          ),
                        ),
                        if (_imagenSeleccionada)
                          const Positioned(
                            right: 10,
                            bottom: 10,
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _handleAudioSelection,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: const Color.fromARGB(255, 133, 192, 23),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _audioSeleccionado
                          ? Colors.green
                          : const Color.fromARGB(255, 175, 173, 36),
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        const Center(
                          child: Text(
                            'Seleccionar Audio',
                            style: TextStyle(
                                color: Color.fromARGB(255, 233, 230, 230)),
                          ),
                        ),
                        if (_audioSeleccionado)
                          const Positioned(
                            right: 10,
                            bottom: 10,
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(onPressed: widget.onSave, text: 'Guardar'),
                MyButton(onPressed: widget.onCancel, text: 'Cancelar'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
