import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../componentes/audio_player.dart';
import '../componentes/dialog_box.dart';
import '../componentes/todo_tile.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import '../componentes/acercade.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('eventsdb');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("EVENTOS") == null) {
      db.createInitialData();
      vaciarEventos();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _Fechacontroller = TextEditingController();
  final _Titulocontroller = TextEditingController();
  final _Descripcioncontroller = TextEditingController();
  String imagen = '';
  String _audio = '';

  void deleteEvento(int index) {
    setState(() {
      db.sampleEvento.removeAt(index);
    });
    db.updateDataBase();
  }

  void vaciarEventos() {
    setState(() {
      db.sampleEvento.clear();
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.sampleEvento.add([
        _Fechacontroller.text,
        _Titulocontroller.text,
        _Descripcioncontroller.text,
        imagen,
        _audio
      ]);
      _Fechacontroller.clear();
      _Titulocontroller.clear();
      _Descripcioncontroller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              Fechacontroller: _Fechacontroller,
              controller: _Titulocontroller,
              Descripcioncontroller: _Descripcioncontroller,
              onSave: saveNewTask,
              onArchivoImagen: selectImagen,
              onArchivoAudio: selectAudio,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void selectImagen() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'tif',
        'webp',
        'svg',
      ],
    );
    if (result == null) return;
    final file = result.files.first;
    final newFile = await guardarArchivo(file);
    imagen = newFile.path;
  }

  void selectAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'mp3',
        'ogg',
        'wav',
      ],
    );
    if (result == null) return;
    final file = result.files.first;
    final newFile = await guardarArchivo(file);
    _audio = newFile.path;
  }

  Future<File> guardarArchivo(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  void showEventDetails(int index) {
    final evento = db.sampleEvento[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(
              255, 255, 254, 254), // Fondo oscuro del diálogo
          title: Text(
            evento[1],
            style: TextStyle(
                color: Color.fromARGB(255, 248, 247, 247)), // Título blanco
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (evento[3] != '')
                Image.file(
                  File(evento[3]),
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 10),
              Text(
                "Fecha: ${evento[0]}",
                style: TextStyle(
                    color:
                        const Color.fromARGB(255, 24, 23, 23)), // Texto blanco
              ),
              SizedBox(height: 10),
              Text(
                "Título: ${evento[1]}",
                style: TextStyle(
                    color:
                        const Color.fromARGB(255, 19, 18, 18)), // Texto blanco
              ),
              SizedBox(height: 10),
              Text(
                "Descripción: ${evento[2]}",
                style: TextStyle(
                    color:
                        const Color.fromARGB(255, 20, 20, 20)), // Texto blanco
              ),
              SizedBox(height: 10),
              if (evento[4] != '') Audio(aud: evento[4]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cerrar",
                style: TextStyle(color: Colors.white), // Texto blanco del botón
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de Incidencias'),
        backgroundColor: Colors.green[800], // Color oscuro para la app bar
      ),
      drawer: Acercade(onVaciar: vaciarEventos),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.green[800], // Color oscuro para el botón
      ),
      body: ListView.builder(
        itemCount: db.sampleEvento.length,
        itemBuilder: (context, index) {
          final evento = db.sampleEvento[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[800], // Color de la tarjeta
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: evento[3] != ''
                  ? Image.file(
                      File(evento[3]),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : null,
              title: Text(
                evento[1],
                style: TextStyle(
                    color: const Color.fromARGB(
                        255, 17, 17, 17)), // Texto blanco del título
              ),
              subtitle: Text(
                "Fecha: ${evento[0]}",
                style: TextStyle(
                    color: Colors.white70), // Texto blanco claro del subtítulo
              ),
              onTap: () => showEventDetails(index),
            ),
          );
        },
      ),
    );
  }
}
