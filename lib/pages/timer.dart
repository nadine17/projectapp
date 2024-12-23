import 'dart:async';
import 'package:flutter/material.dart';

class timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Duration duration = Duration.zero;
  Timer? timer;
  bool isRunning = false;

  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();

  @override
  void dispose() {
    timer?.cancel();
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  void startTimer() {
    if (duration.inSeconds > 0) {
      setState(() {
        isRunning = true;
      });

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (duration.inSeconds > 0) {
            duration = duration - Duration(seconds: 1);
          } else {
            timer.cancel();
            isRunning = false;
            _showCongratulationsDialog(); // Show message when timer finishes
          }
        });
      });
    }
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String formatTime(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void setTimer() {
    int hours = int.tryParse(hoursController.text) ?? 0;
    int minutes = int.tryParse(minutesController.text) ?? 0;
    int seconds = int.tryParse(secondsController.text) ?? 0;

    setState(() {
      duration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "!!عاش يا بطل كمل",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "فخورين بيك",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "تمامم يخويا",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: hoursController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hours',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: minutesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Minutes',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: secondsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Seconds',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: setTimer,
                    child: Text('Set Timer'),
                  ),
                ],
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: duration.inSeconds > 0
                          ? duration.inSeconds / (duration.inSeconds + 1)
                          : 0,
                      strokeWidth: 10,
                      color: Colors.red,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Text(
                    formatTime(duration),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: isRunning ? null : startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isRunning ? stopTimer : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Stop',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
