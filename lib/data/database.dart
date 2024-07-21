import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List sampleEvento = [];

  // reference our box
  final _myBox = Hive.box('eventsdb');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    sampleEvento = [
      ['', '', '', '', ''],
    ];
  }

  // load the data from database
  void loadData() {
    sampleEvento = _myBox.get("EVENTOS");
    print(sampleEvento);
  }

  // update the database
  void updateDataBase() {
    _myBox.put("EVENTOS", sampleEvento);
  }
}
