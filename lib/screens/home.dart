import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const Home());

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AudioRecorder record;
  late final AudioPlayer player;
  bool isRecording = false;
  bool isPlaying = false;
  String audioPath = '';

  @override
  void initState() {
    player = AudioPlayer();
    record = AudioRecorder();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.next_plan_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/audio');
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
          children: [
            if (isRecording)
              const Text(
                'Record in Progress',
                style: TextStyle(fontSize: 20),
              )
            else
              const Text(
                '',
              ),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording,
              child: isRecording
                  ? const Text('Stop Record')
                  : const Text('Start Record'),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 25,
            ),
            if (!isRecording)
              ElevatedButton(
                  onPressed: isPlaying ? stopPlaying : startPlaying,
                  child: isPlaying
                      ? const Text('Stop Record')
                      : const Text('Play Record'))
          ],
        )),
      ),
    );
  }

  Future<void> startRecording() async {
    try {
      if (await record.hasPermission()) {
        await record.start(const RecordConfig(), path: audioPath);

        record.start(const RecordConfig(), path: audioPath);
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Start Recording: $e');
      }
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await (record.stop());
      setState(() {
        isRecording = false;
        audioPath = path!; // asigns the path to audioPath
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error Stopping Recording: $e');
      }
    }
  }

  Future<void> startPlaying() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await player.play(urlSource);
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error Playing Record: $e');
      }
    }
  }

  Future<void> stopPlaying() async {
    try {
      await (player.stop());
      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error Stopping Playing: $e');
      }
    }
  }
}
