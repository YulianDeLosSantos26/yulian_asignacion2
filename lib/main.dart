import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';
import 'componentes/audio_player.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('eventsdb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          primaryColor: Color(
              int.parse('#a4947c'.substring(1, 7), radix: 16) + 0xFF000000),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundColor: Colors.red[60]),
          appBarTheme: AppBarTheme(
              color: Color(
                  int.parse('#a4947c'.substring(1, 7), radix: 16) + 0xFF000000),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0)),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: const Color.fromARGB(255, 0, 0, 0),
                displayColor: const Color.fromARGB(255, 2, 2, 2),
              )),
    );
  }
}
