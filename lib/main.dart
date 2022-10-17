// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer audioPlayer;
  String durasi = "00:00";
  bool isPause = false;

  _MyAppState() {
    audioPlayer = AudioPlayer();
    audioPlayer.onPositionChanged.listen((duration) {
      setState(() {
        durasi = duration.toString();
      });
      audioPlayer.setReleaseMode(ReleaseMode.loop);
    });
  }

  void playAudio(String url) async {
    await audioPlayer.play(UrlSource(url));
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  void stopAudio() async {
    await audioPlayer.stop();
  }

  void resumeAudio() async {
    await audioPlayer.resume();
  }

  void fastForward() async {
    await audioPlayer.seek(const Duration(seconds: 15));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Playing Music'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  playAudio(
                      "https://samplelib.com/lib/preview/mp3/sample-12s.mp3");
                },
                child: Text('Play'),
              ),
              RaisedButton(
                onPressed: () {
                  (isPause = false) ? resumeAudio() : pauseAudio();
                },
                child: Text((isPause = false) ? 'Resume' : 'Pause'),
              ),
              RaisedButton(
                onPressed: () {
                  stopAudio();
                },
                child: Text('Stop'),
              ),
              RaisedButton(
                onPressed: () {
                  fastForward();
                },
                child: Text('Fast Forward'),
              ),
              Text(
                durasi,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
