import 'package:flutter/material.dart';

import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class Alternative extends StatefulWidget {
  const Alternative({Key? key}) : super(key: key);

  @override
  State<Alternative> createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          // child: showPlayer
          //     ? Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 25),
          //         child: AudioPlayer(
          //           source: audioPath!,
          //           onDelete: () {
          //             setState(() => showPlayer = false);
          //           },
          //         ),
          //       )
          //     : AudioRecorder(
          //         onStop: (path) {
          //           if (kDebugMode) print('Recorded file path: $path');
          //           setState(() {
          //             audioPath = path;
          //             showPlayer = true;
          //           });
          //         },
          //       ),
          child: Text('Errors on sight'),
        ),
      ),
    );
  }
}