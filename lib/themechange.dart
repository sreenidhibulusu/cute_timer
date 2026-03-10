import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';

Map<String, List<String>> themes = {
  'left': ['rain', 'assets/rain_2_1080X1080.gif'],
  'right': ['sun', 'assets/the_sun_1080X1080.gif'],
};

class TimerWindow extends StatefulWidget {
  const TimerWindow({super.key});

  @override
  State<TimerWindow> createState() {
    return _TimerWindowState();
  }
}

class _TimerWindowState extends State<TimerWindow> {
  var whichButton = 'left';
  var displayGif = themes['left']![1];
  final stopwatch = Stopwatch();

  void changeWindow(var whichButton) {
    setState(() {
      if(whichButton == 'left') {
        displayGif = themes['left']![1];
      }
      if (whichButton == 'right') {
        displayGif = themes['right']![1];
      }
    });
  }

  var playButton = false;
  var iconUsed = 'assets/pause_1-removebg-preview.png';

  void changePlayButton() {
    setState(() {
      playButton = !playButton;
      if (playButton == false) {
        stopwatch.stop();
        iconUsed = 'assets/pause_1-removebg-preview.png';
      } else {
        stopwatch.start();
        iconUsed = 'assets/play-removebg-preview.png';
      }
    });
  }

  void resetTime() {
    setState(() {
      stopwatch.reset();
    });
  }

  String getTime() {
    var hours = stopwatch.elapsed.inHours.toString().padLeft(2, '0');
    var minutes = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
    var seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(context) {
    return Scaffold( 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () => changeWindow('left'),
                    icon: Image.asset(
                      'assets/slide_button_left-removebg-preview.png',
                    ),
                  ),
                ),
                GifView.asset(
                  displayGif,
                  height: 300,
                  width: 300,
                  autoPlay: true,
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () => changeWindow('right'),
                    icon: Image.asset(
                      'assets/slide_button_right-removebg-preview.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(
              width: 300,
              height: 100,
              child: Text(
                getTime(),
                textAlign: TextAlign.center,
                style: GoogleFonts.bitcountGridSingleInk(
                  fontSize: 60,
                ),
              ),
            ),
          ],
        ),
      ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: resetTime,
                    icon: Image.asset(
                      'assets/Reset-removebg-preview.png',
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () => changePlayButton(),
                    icon: Image.asset(
                      iconUsed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset('assets/stopwatch-removebg-preview.png'),
              ),
            label: 'stopwatch',
          ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset('assets/timer-removebg-preview.png'),
          ),
          label: 'timer',
        )
        ],
      ),
    );
  }
}
