import 'package:flutter/material.dart';
import 'package:practicas/screens/alternative.dart';
import 'package:practicas/screens/audio_recorder.dart';
import 'package:practicas/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const Home(),
        '/alt': (BuildContext context) => const Alternative(),
        '/audio': (BuildContext context) => const AudioRecorderWidget(),
      },
    );
  }
}
