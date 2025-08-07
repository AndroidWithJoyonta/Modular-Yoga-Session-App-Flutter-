import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/pose_model.dart';

class AudioScreen extends StatefulWidget {
  final int initialIndex;
  final List<Pose> poseList;

  const AudioScreen({
    super.key,
    required this.initialIndex,
    required this.poseList,
  });

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _player = AudioPlayer();
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool isPlaying = false;
  late int currentIndex;

  Pose get currentPose => widget.poseList[currentIndex];

  void _playAudio() async {
    await _player.play(AssetSource(currentPose.audio));
  }

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;
    // Listen to duration updates
    _player.onDurationChanged.listen((duration) {
      setState(() => _totalDuration = duration);
    });

    // Listen to position updates
    _player.onPositionChanged.listen((position) {
      setState(() => _currentPosition = position);
    });

    _playAudio();
    isPlaying = true;

  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  // Usage in widget:

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }


  void _togglePlayPause(){

    if(isPlaying){

      _player.pause();
    }else{
      _player.resume();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }


  void nextMusic(){

    if(currentIndex < widget.poseList.length -1){

      setState(() {
        currentIndex++;
      });

      _playAudio();

    }
  }

  void previousMusic(){

    if(currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''),backgroundColor: Colors.white),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      currentPose.name,
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),

                    Image.asset(
                      currentPose.image,
                      width: 300,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    Slider(
                      min: 0,
                      max: _totalDuration.inSeconds.toDouble(),
                      value: _currentPosition.inSeconds.toDouble().clamp(
                        0.0,
                        _totalDuration.inSeconds.toDouble(),
                      ),
                      onChanged: (value) {
                        _player.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: Colors.blue,      // Color of the filled part
                      inactiveColor: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(_currentPosition),style: TextStyle(fontSize: 15),),
                          Text(currentPose.duration.toString(),style: TextStyle(fontSize: 15),),

                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: previousMusic,
                          icon: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.1416), // 180 degrees in radians
                            child: Icon(Icons.double_arrow_sharp, size: 40,color: Colors.purple[100]),
                          ),
                        ),

                        IconButton(
                          onPressed: _togglePlayPause,
                          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle,size:50,color: Colors.purple[300]),
                        ),

                        IconButton(
                          onPressed: nextMusic,
                          icon: Icon(Icons.double_arrow_sharp,size: 40,color: Colors.purple[100],),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
