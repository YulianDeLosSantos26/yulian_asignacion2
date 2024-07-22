import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List sampleEvento = [];

  final _myBox = Hive.box('eventsdb');

  void createInitialData() {
    sampleEvento = [
      ['', '', '', '', ''],
    ];
  }

  // Cargar datos de la db
  void loadData() {
    sampleEvento = _myBox.get("EVENTOS");
    print(sampleEvento);
  }

  // Actualizar mi db
  void updateDataBase() {
    _myBox.put("EVENTOS", sampleEvento);
  }
}
