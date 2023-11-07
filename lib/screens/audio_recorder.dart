import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({super.key});

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();

  late bool _recordState;
  bool _isRecording = false;
  bool _isPlaying = false;
  String audioPath = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _recordState = false;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: audioPath);
        setState(() {
          _isRecording = true;
        });
      } else {
        const SnackBar(
          content: Text('No tienes permisos para grabar audio.'),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      bool recording = await _audioRecorder.isRecording();
      setState(() {
        _recordState = recording;
        _isRecording = _recordState;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await _audioPlayer.play(urlSource);
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stopPlaying() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.next_plan_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/alt');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
              'Duración de la grabación: ${_audioPlayer.getDuration().toString()}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                onPressed: _isRecording ? _stopRecording : _startRecording,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                onPressed: _isPlaying ? _stopPlaying : _playRecording,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
