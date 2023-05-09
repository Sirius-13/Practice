import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class player_screen extends StatelessWidget {
  const player_screen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PlayerScreenPage(title: 'Playing...'),
    );
  }
}

class PlayerScreenPage extends StatefulWidget {
  const PlayerScreenPage({super.key, required this.title});

  final String title;

  @override
  State<PlayerScreenPage> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreenPage> {

  //MediaQuery
  double screenHeight = 0;
  double screenWidth = 0;

  //AudioPlayer
  final player = AudioPlayer();

  //Play and Pause
  bool isPlaying = false;

  //Time and Duration
  Duration? duration = Duration(seconds: 0);
  double value = 0;

  void initPlayer() async {
    await player.setSource(AssetSource("A_New_Start.mp3"));
    duration = await player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  Widget build(BuildContext context) {
    //MediaQuery
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    void playPause() {
      setState(() {
        isPlaying = !isPlaying;
      });
    }

    return Scaffold(
      backgroundColor: Color(0x6B38FF),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          }),
        backgroundColor: Color(0x101820FF),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 35.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            //Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                'https://static.wikia.nocookie.net/virtualyoutuber/images/5/55/Nanashi_Mumei_-_A_New_Start.jpg/revision/latest/scale-to-width-down/1000?cb=20220116162710',
                scale: 3.5,
              ),
            ),
            //Song Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('A New Start',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            //Artist Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 30.0),
                    child: Text('Nanashi Mumei',
                        style: TextStyle(color: Colors.white, fontSize: 15))),
              ],
            ),
            //Audio Slider Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 315.0,
                  child: Slider.adaptive(
                    onChangeEnd: (new_value) async {
                      setState(() {
                        value = new_value;
                        // print(new_value);
                      });
                      await player.seek(Duration(seconds: new_value.toInt()));
                    },
                    min: 0.0,
                    value: value,
                    max: 200.0,
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                  ),
                ),
              ],
            ),
            //Time Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${(value / 60).floor()} : ${(value.floor() % 60).floor()}',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(width: 200),
                Text('${duration!.inMinutes} : ${duration!.inSeconds % 60}',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            //Play Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.0, 0, 10.0)
                ),
                IconButton(
                  icon: Icon(Icons.skip_previous_rounded),
                  onPressed: () {},
                  iconSize: 50,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                IconButton(
                  icon: isPlaying
                      ? Icon(Icons.pause_circle_outline_rounded)
                      : Icon(Icons.play_circle_rounded),
                  onPressed: () {
                    playPause();
                    setState(() {
                      if (isPlaying) {
                        player.play(AssetSource('A_New_Start.mp3'));
                        player.onPositionChanged.listen((position) {
                          setState(() {
                            value = position.inSeconds.toDouble();
                          });
                        });
                      } else {
                        player.pause();
                      }
                    });
                  },
                  iconSize: 50,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next_rounded),
                  onPressed: () {},
                  iconSize: 50,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
