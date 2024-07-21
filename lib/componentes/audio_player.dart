import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio extends StatefulWidget {
  final String aud;
  Audio({required this.aud});
  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      player.pause();
                    } else {
                      await player.play(DeviceFileSource(widget.aud));
                    }
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                radius: 25,
                child: IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    player.stop();
                  },
                ),
              ),
            ],
          ),
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              final position = Duration(seconds: value.toInt());
              player.seek(position);
              player.resume();
            },
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position.inSeconds)),
                Text(formatTime((duration - position).inSeconds)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
