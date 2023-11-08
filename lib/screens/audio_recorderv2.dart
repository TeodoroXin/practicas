import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';


void main() => runApp(const AudioRecorderWidgetv2());

class AudioRecorderWidgetv2 extends StatefulWidget {
  const AudioRecorderWidgetv2({Key? key}) : super(key: key);

  @override
  State<AudioRecorderWidgetv2> createState() => _AudioRecorderWidgetv2State();
}

class _AudioRecorderWidgetv2State extends State<AudioRecorderWidgetv2> {
  bool showPlayer = false;
  late final AudioRecorder audioRecorder;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    audioRecorder = AudioRecorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: showPlayer
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AudioPlayer(
                    source: audioPath!,
                    onDelete: () {
                      setState(() => showPlayer = false);
                    },
                  ),
                )
              : ElevatedButton(
                  onPressed: startRecording, child: const Text('Start Recording')),
        ),
      ),
    );
  }

  Future<void> startRecording() async {
    // Check and request permission if needed
    if (await audioRecorder.hasPermission()) {
      // Start recording to file
      await audioRecorder.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');
      
    }
  }
}
