import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  // runApp(const player_screen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Audio Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //MediaQuery
  double screenHeight = 0;
  double screenWidth = 0;

  //PlayList
  var playList = [
    {"songName": "A New Start", "artistName": "Nanashi Mumei"},
    {"songName": "Stellar Stellar", "artistName": "Hoshimachi Suisei"},
    {"songName": "Yume Hanabi", "artistName": "Nakiri Ayame"},
    {"songName": "Kaijyu no Hanauta", "artistName": "Vaundy"},
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0x6B38FF),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF66B933),
      ),
      body: ListView.separated(
          itemCount: playList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.white,
              ),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // leading: const Icon(Icons.list),
              // trailing: const Text(
              //   "GFG",
              //   style: TextStyle(color: Colors.green, fontSize: 15),
              // ),
              title: Text("${playList[index]['songName']}",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("${playList[index]['artistName']}",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerScreenPage(selectedSong: playList[index])));
                // print(playList[index]);
                },
            );
          }),
      //Bottom Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Favourite',
          ),
        ],
        // currentIndex: _selectedIndex,
        backgroundColor: Color(0xFF66B933),
        selectedItemColor: Colors.white,
        // onTap: _onItemTapped,
      ),
    );
  }
}

class PlayerScreenPage extends StatefulWidget {
  const PlayerScreenPage({super.key, required this.selectedSong});

  final Map<String, String> selectedSong;

  @override
  State<PlayerScreenPage> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreenPage> {

  //MediaQuery
  double screenHeight = 0;
  double screenWidth = 0;

  //PlayList
  var playList = [
    {"songName": "A New Start", "artistName": "Nanashi Mumei"},
    {"songName": "Stellar Stellar", "artistName": "Hoshimachi Suisei"},
    {"songName": "Yume Hanabi", "artistName": "Nakiri Ayame"},
    {"songName": "Kaijyu no Hanauta", "artistName": "Vaundy"},
  ];

  //AudioPlayer
  final player = AudioPlayer();

  //Play and Pause
  bool isPlaying = false;
  //Loop Song
  bool isLooping = false;
  //Favourite a Song
  bool isFavourite = false;

  //Cover Image Link
  String coverImgLink = '';
  //Song Link
  String songPath = '';

  //Time and Duration
  Duration? position = new Duration();
  Duration? duration = new Duration();

  //Slider value
  double value = 0;

  //Index of Selected Song from PlayList
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void autoPlay() {
    setState(() {
      isPlaying = true;
      setState(() {
        if (isPlaying) {
          player.play(AssetSource(songPath));
          player.onPositionChanged.listen((_position) {
            setState(() {
              value = _position.inSeconds.toDouble();
              position = _position;
              // print(position);
            });
          });
        } else {
          player.pause();
        }
      });
    });
  }

  void initPlayer() async {
    for (int i = 0; i < playList.length; i++) {
      if (widget.selectedSong['songName'] == playList[i]['songName']) {
        currentIndex = i;
      }
    }
    if (isPlaying == false) {
      if (widget.selectedSong['songName'] == 'A New Start') {
        coverImgLink =
        "https://hololive.hololivepro.com/wp-content/uploads/2022/01/Nanashi-Mumei_ANewStart_Jk-1536x1536.png";
        songPath = 'A_New_Start.mp3';
        await player.setSource(AssetSource(songPath));
        await player.onDurationChanged.first;
        duration = await player.getDuration();
        autoPlay();
      }
      if (widget.selectedSong['songName'] == 'Stellar Stellar') {
        coverImgLink =
        "https://cdn.shopify.com/s/files/1/0529/2641/5045/products/1220__1st_StillStillStellar_fa5fe8e6-a2f8-483a-a4f7-464fc9f8efdd.png?v=1639564807";
        songPath = 'Stellar_Stellar.mp3';
        await player.setSource(AssetSource(songPath));
        await player.onDurationChanged.first;
        duration = await player.getDuration();
        autoPlay();
      }
      if (widget.selectedSong['songName'] == 'Yume Hanabi') {
        coverImgLink =
        "https://hololive.hololivepro.com/wp-content/uploads/2022/12/%E7%99%BE%E9%AC%BC%E3%81%82%E3%82%84%E3%82%81_%E5%A4%A2%E8%8A%B1%E7%81%AB_jk.png";
        songPath = 'Yume_Hanabi.mp3';
        await player.setSource(AssetSource(songPath));
        await player.onDurationChanged.first;
        duration = await player.getDuration();
        autoPlay();
      }
      if (widget.selectedSong['songName'] == 'Kaijyu no Hanauta') {
        coverImgLink =
        "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSZ6AYUQciI9nHNWbwIBdQxMmYzKa01gctB0tO9Y6Kkra7nL-jm";
        songPath = 'Kaijyu_no_Hanauta.mp3';
        await player.setSource(AssetSource(songPath));
        await player.onDurationChanged.first;
        duration = await player.getDuration();
        autoPlay();
      }
    }
  }

  Widget build(BuildContext context) {
    //MediaQuery
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    //Play and Pause Function
    void playPause() {
      setState(() {
        isPlaying = !isPlaying;
        setState(() {
          if (isPlaying) {
            player.play(AssetSource(songPath));
            player.onPositionChanged.listen((_position) {
              setState(() {
                value = _position.inSeconds.toDouble();
                position = _position;
                // print(position);
              });
            });
          } else {
            player.pause();
          }
        });
      });
    }

    //Play Next Song
    void playNext() async {
      currentIndex++;
      if (currentIndex >= playList.length) {
        currentIndex = 0; // Wrap around to the beginning of the playlist
      }
      // Load and play the new song
      setState(() {
        isPlaying = false; // Pause the current song
        position = Duration.zero;
        value = 0;
        widget.selectedSong['songName'] = playList[currentIndex]['songName']!;
        widget.selectedSong['artistName'] = playList[currentIndex]['artistName']!;
        initPlayer();
      });
    }

    //Play Previous Song
    void playPrevious() async {
      currentIndex--;
      //To Get Last Index of PlayList
      for (int i = 0; i < playList.length; i++) {
        if (currentIndex < 0 && i == playList.length - 1) {
          currentIndex = i;
        }
      }
      // Load and play the new song
      setState(() {
        isPlaying = false; // Pause the current song
        position = Duration.zero;
        value = 0;
        widget.selectedSong['songName'] = playList[currentIndex]['songName']!;
        widget.selectedSong['artistName'] = playList[currentIndex]['artistName']!;
        initPlayer();
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
        backgroundColor: Color(0xFF66B933),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 45.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            //Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                coverImgLink,
                width: 300,
                height: 300,
                scale: 0.5,
              ),
            ),
            //Song Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(widget.selectedSong['songName']!,
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
                    child: Text(widget.selectedSong['artistName']!,
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
                      });
                      await player.seek(Duration(seconds: new_value.toInt()));
                    },
                    min: 0.0,
                    value: value,
                    max: duration!.inMilliseconds / 1000,
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
                Text('${position.toString().split(".")[0].split(":")[1]} : ${position.toString().split(".")[0].split(":")[2]}' ,
                    style: TextStyle(color: Colors.grey)),
                SizedBox(width: 180),
                Text('${duration.toString().split(".")[0].split(":")[1]} : ${duration.toString().split(".")[0].split(":")[2]}',
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
                //Loop Button
                IconButton(
                  icon: isLooping? Icon(Icons.loop) : Icon(Icons.shuffle),
                  onPressed: () {
                    setState(() {
                      isLooping = !isLooping;
                    });
                    if (isLooping) {
                      player.setReleaseMode(ReleaseMode.loop);
                    }
                  },
                  iconSize: 30,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                //Previous Button
                IconButton(
                  icon: Icon(Icons.skip_previous_rounded),
                  onPressed: () {
                    playPrevious();
                  },
                  iconSize: 50,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                //Play Button
                IconButton(
                  icon: isPlaying
                      ? Icon(Icons.pause_circle_outline_rounded)
                      : Icon(Icons.play_circle_rounded),
                  onPressed: () {
                    playPause();
                  },
                  iconSize: 50,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                //Next Button
                IconButton(
                  icon: Icon(Icons.skip_next_rounded),
                  onPressed: () {
                    playNext();
                  },
                  iconSize: 50,
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                //Favourite Button
                IconButton(
                  icon: isFavourite? Icon(Icons.favorite) : Icon(Icons.favorite_outline),
                  onPressed: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  iconSize: 30,
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




