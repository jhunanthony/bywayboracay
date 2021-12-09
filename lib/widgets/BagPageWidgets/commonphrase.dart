import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../Navigation/TopNavBar.dart';

class CommonPhrasePage extends StatefulWidget {
  //const TextToSpeech({Key key}) : super(key: key);

  @override
  _CommonPhrasePageState createState() => _CommonPhrasePageState();
}

class _CommonPhrasePageState extends State<CommonPhrasePage> {
  bool isSpeaking1 = false;
  bool isSpeaking2 = false;
  bool isSpeaking3 = false;
  bool isSpeaking4 = false;
  bool isSpeaking5 = false;
  bool isSpeaking6 = false;
  bool isSpeaking7 = false;
  bool isSpeaking8 = false;
  final String _controller1 = 'Hay';
  final String _controller2 = 'huo';
  final String _controller3 = 'indi';
  final String _controller4 = 'kun mahimo';
  final String _controller5 = 'pasensyaha ako';
  final String _controller6 = 'kamusta ka?';
  final String _controller7 = 'saeamat';
  final String _controller8 = 'mayad nga agahon';

  final _flutterTts1 = FlutterTts();
  final _flutterTts2 = FlutterTts();
  final _flutterTts3 = FlutterTts();
  final _flutterTts4 = FlutterTts();
  final _flutterTts5 = FlutterTts();
  final _flutterTts6 = FlutterTts();
  final _flutterTts7 = FlutterTts();
  final _flutterTts8 = FlutterTts();

  void initializeTts() {
    _flutterTts1.setStartHandler(() {
      setState(() {
        isSpeaking1 = true;
      });
    });
    _flutterTts1.setCompletionHandler(() {
      setState(() {
        isSpeaking1 = false;
      });
    });
    _flutterTts1.setErrorHandler((message) {
      setState(() {
        isSpeaking1 = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  void speak1() async {
    if (_controller1.toString().isNotEmpty) {
      await _flutterTts1.speak(_controller1.toString());
    }
  }

  void stop1() async {
    await _flutterTts1.stop();
    setState(() {
      isSpeaking1 = false;
    });
  }

  @override
  void dispose() {
    _flutterTts1.stop();
    super.dispose();
  }

  // 2nd

  void speak2() async {
    if (_controller2.toString().isNotEmpty) {
      await _flutterTts2.speak(_controller2.toString());
    }
  }

  void stop2() async {
    await _flutterTts2.stop();
    setState(() {
      isSpeaking2 = false;
    });
  }

  void initializeTts2() {
    _flutterTts2.setStartHandler(() {
      setState(() {
        isSpeaking2 = true;
      });
    });
    _flutterTts2.setCompletionHandler(() {
      setState(() {
        isSpeaking2 = false;
      });
    });
    _flutterTts2.setErrorHandler((message) {
      setState(() {
        isSpeaking2 = false;
      });
    });
  }

  @override
  void initState2() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose2() {
    _flutterTts2.stop();
    super.dispose();
  }

  //3RD BATCH
  //
  void speak3() async {
    if (_controller3.toString().isNotEmpty) {
      await _flutterTts3.speak(_controller3.toString());
    }
  }

  void stop3() async {
    await _flutterTts3.stop();
    setState(() {
      isSpeaking3 = false;
    });
  }

  void initializeTts3() {
    _flutterTts3.setStartHandler(() {
      setState(() {
        isSpeaking3 = true;
      });
    });
    _flutterTts3.setCompletionHandler(() {
      setState(() {
        isSpeaking3 = false;
      });
    });
    _flutterTts3.setErrorHandler((message) {
      setState(() {
        isSpeaking3 = false;
      });
    });
  }

  @override
  void initState3() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose3() {
    _flutterTts3.stop();
    super.dispose();
  }

// 4TH BATCH
  void speak4() async {
    if (_controller4.toString().isNotEmpty) {
      await _flutterTts4.speak(_controller4.toString());
    }
  }

  void stop4() async {
    await _flutterTts4.stop();
    setState(() {
      isSpeaking4 = false;
    });
  }

  void initializeTts4() {
    _flutterTts4.setStartHandler(() {
      setState(() {
        isSpeaking4 = true;
      });
    });
    _flutterTts4.setCompletionHandler(() {
      setState(() {
        isSpeaking4 = false;
      });
    });
    _flutterTts4.setErrorHandler((message) {
      setState(() {
        isSpeaking4 = false;
      });
    });
  }

  @override
  void initState4() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose4() {
    _flutterTts3.stop();
    super.dispose();
  }

// 5TH BATCH
  void speak5() async {
    if (_controller5.toString().isNotEmpty) {
      await _flutterTts5.speak(_controller5.toString());
    }
  }

  void stop5() async {
    await _flutterTts5.stop();
    setState(() {
      isSpeaking5 = false;
    });
  }

  void initializeTts5() {
    _flutterTts5.setStartHandler(() {
      setState(() {
        isSpeaking5 = true;
      });
    });
    _flutterTts5.setCompletionHandler(() {
      setState(() {
        isSpeaking5 = false;
      });
    });
    _flutterTts5.setErrorHandler((message) {
      setState(() {
        isSpeaking5 = false;
      });
    });
  }

  @override
  void initState5() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose5() {
    _flutterTts5.stop();
    super.dispose();
  }

// 6TH BATCH
  void speak6() async {
    if (_controller6.toString().isNotEmpty) {
      await _flutterTts6.speak(_controller6.toString());
    }
  }

  void stop6() async {
    await _flutterTts6.stop();
    setState(() {
      isSpeaking6 = false;
    });
  }

  void initializeTts6() {
    _flutterTts6.setStartHandler(() {
      setState(() {
        isSpeaking6 = true;
      });
    });
    _flutterTts6.setCompletionHandler(() {
      setState(() {
        isSpeaking6 = false;
      });
    });
    _flutterTts6.setErrorHandler((message) {
      setState(() {
        isSpeaking6 = false;
      });
    });
  }

  @override
  void initState6() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose6() {
    _flutterTts6.stop();
    super.dispose();
  }

// 7TH BATCH
  void speak7() async {
    if (_controller7.toString().isNotEmpty) {
      await _flutterTts7.speak(_controller7.toString());
    }
  }

  void stop7() async {
    await _flutterTts7.stop();
    setState(() {
      isSpeaking7 = false;
    });
  }

  void initializeTts7() {
    _flutterTts7.setStartHandler(() {
      setState(() {
        isSpeaking7 = true;
      });
    });
    _flutterTts7.setCompletionHandler(() {
      setState(() {
        isSpeaking7 = false;
      });
    });
    _flutterTts7.setErrorHandler((message) {
      setState(() {
        isSpeaking7 = false;
      });
    });
  }

  @override
  void initState7() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose7() {
    _flutterTts7.stop();
    super.dispose();
  }

// 8TH BATCH
  void speak8() async {
    if (_controller8.toString().isNotEmpty) {
      await _flutterTts8.speak(_controller8.toString());
    }
  }

  void stop8() async {
    await _flutterTts8.stop();
    setState(() {
      isSpeaking8 = false;
    });
  }

  void initializeTts8() {
    _flutterTts8.setStartHandler(() {
      setState(() {
        isSpeaking8 = true;
      });
    });
    _flutterTts8.setCompletionHandler(() {
      setState(() {
        isSpeaking8 = false;
      });
    });
    _flutterTts7.setErrorHandler((message) {
      setState(() {
        isSpeaking8 = false;
      });
    });
  }

  @override
  void initState8() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }

  @override
  void dispose8() {
    _flutterTts8.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'COMMON PHRASES',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ENGLISH',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text('LOCAL',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text('AUDIO',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Hello', style: TextStyle(fontSize: 15)),
                  Text('Hay', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking1 ? stop1() : speak1();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking1 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Yes', style: TextStyle(fontSize: 15)),
                  Text('Hu-o', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking2 ? stop2() : speak2();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking2 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('No', style: TextStyle(fontSize: 15)),
                  Text('In-di', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking3 ? stop3() : speak3();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking3 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please', style: TextStyle(fontSize: 15)),
                  Text('Kun Mahimo', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking4 ? stop4() : speak4();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking4 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Excuse', style: TextStyle(fontSize: 15)),
                  Text('Pasenyaha ako', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking5 ? stop5() : speak5();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking5 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('How are you?', style: TextStyle(fontSize: 15)),
                  Text('Kamusta ka?', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking6 ? stop6() : speak6();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking6 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Thankyou', style: TextStyle(fontSize: 15)),
                  Text('Saeamat', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking7 ? stop7() : speak7();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking7 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Good Morning', style: TextStyle(fontSize: 15)),
                  Text('Mayad nga agahan', style: TextStyle(fontSize: 15)),
                  ElevatedButton(
                    onPressed: () {
                      isSpeaking8 ? stop8() : speak8();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        Text(isSpeaking8 ? "Stop" : "")
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //background
                      onPrimary: Colors.white,
                      //foreground
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 2,
              ),

              ///////////2ND COLUMN ////////////
            ],
          ),
        ),
      ),
    );
  }
}
