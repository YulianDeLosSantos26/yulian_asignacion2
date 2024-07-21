import 'package:flutter/material.dart';
import 'dart:io';
import 'audio_player.dart';

class ToDoTile extends StatelessWidget {
  final String fecha;
  final String titulo;
  final String descripcion;
  final String imagen;
  final String audio;
  Function()? onPressed;

  ToDoTile(
      {required this.fecha,
      required this.titulo,
      required this.descripcion,
      required this.imagen,
      required this.audio,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: Color(int.parse('#a4947c'.substring(1, 7), radix: 16) +
                    0xFF000000),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.file(
                      File(imagen),
                      height: 175,
                      width: 175,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 135,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fecha),
                          const SizedBox(height: 10),
                          Text(titulo),
                          const SizedBox(height: 10),
                          Text(descripcion),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                  ],
                ),
                Container(
                    child: Audio(
                  aud: audio,
                )),
              ],
            )));
  }
}
