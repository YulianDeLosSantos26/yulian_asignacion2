import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../componentes/audio_player.dart';
import '../componentes/dialog_box.dart';
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
    final audioWidget = Audio(
      aud: evento[4],
      onStop: () {
        // Detener el audio al cerrar el diálogo o cuando se detiene manualmente
      },
    );

    showDialog(
      context: context,
      builder: (context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            audioWidget.onStop!(); // Detiene el audio al cerrar el diálogo
            return true;
          },
          child: AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 254, 254),
            title: Text(
              evento[1],
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (evento[3] != '')
                    Image.file(
                      File(evento[3]),
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 10),
                  const Text(
                    "Fecha:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 24, 23, 23)),
                  ),
                  Text(
                    evento[0],
                    style:
                        const TextStyle(color: Color.fromARGB(255, 24, 23, 23)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Título:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 19, 18, 18)),
                  ),
                  Text(
                    evento[1],
                    style:
                        const TextStyle(color: Color.fromARGB(255, 19, 18, 18)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Descripción:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 20, 20)),
                  ),
                  Text(
                    evento[2],
                    style:
                        const TextStyle(color: Color.fromARGB(255, 20, 20, 20)),
                  ),
                  const SizedBox(height: 10),
                  if (evento[4] != '') audioWidget,
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  audioWidget
                      .onStop!(); // Detener el audio al cerrar el diálogo
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registro de Incidencias',
            style: TextStyle(color: Colors.white70)),
        backgroundColor: Colors.green[800],
      ),
      drawer: Acercade(onVaciar: vaciarEventos),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.sampleEvento.length,
        itemBuilder: (context, index) {
          final evento = db.sampleEvento[index];
          return Card(
            margin: const EdgeInsets.all(10),
            color: Colors.grey[800],
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
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
                style: const TextStyle(
                    color: Colors.white70), // Texto blanco del título
              ),
              subtitle: Text(
                "Fecha: ${evento[0]}",
                style: const TextStyle(
                    color: Colors.white70), // Texto blanco claro del subtítulo
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Confirmar la eliminación
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Confirmar eliminación"),
                        content: const Text(
                            "¿Estás seguro de que deseas eliminar este registro de policia secreto?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el diálogo
                            },
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteEvento(index); // Elimina el evento
                              Navigator.of(context).pop(); // Cierra el diálogo
                            },
                            child: const Text("Eliminar"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              onTap: () => showEventDetails(index),
            ),
          );
        },
      ),
    );
  }
}
