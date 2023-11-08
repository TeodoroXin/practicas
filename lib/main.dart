import 'package:flutter/material.dart';

import 'package:practicas/screens/home.dart';
import 'package:practicas/screens/audio_recorder.dart';
import 'package:practicas/screens/audio_recorderv2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/alt',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const Home(),
        '/alt': (BuildContext context) => const AudioRecorderWidgetv2(),
        '/audio': (BuildContext context) => const AudioRecorderWidget(),
      },
    );
  }
}
