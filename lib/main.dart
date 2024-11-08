import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = '00', digitMinutes = '00', digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps =[];

  void stopFunction(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }
  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';
       started = false;
    });
  }
  void addlaps(){
    String lap = '$digitHours:$digitMinutes:$digitSeconds';
    setState(() {
      laps.add(lap);
    });
  }
  void startTimer(){
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer){
      int localSeconds = seconds+ 1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds >59){
        if(localMinutes>59){
          localHours++;
          localMinutes = 0;
        }else{
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSeconds = (seconds >= 10)? '$seconds' : '0$seconds';
        digitMinutes = (minutes >= 10)? '$minutes' : '0$minutes';
        digitHours = (hours >= 10)? '$hours' : '0$hours';

      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.black45,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                      'StopWatch',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height:20.0),
                Center(
                  child: Text(
                    '$digitHours:$digitMinutes:$digitSeconds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    itemCount: laps.length,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lap ${index+1}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${laps[index]}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                      }
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: (){
                         (!started) ? startTimer() : stopFunction();
                        },
                        fillColor: Colors.deepPurple,
                      shape: StadiumBorder(
                        side: BorderSide.none
                      ),
                        child: Text(
                          (!started)? 'START' : 'PAUSE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                    IconButton(onPressed: (){
                      addlaps();

                       },
                        icon: Icon(Icons.flag),
                      color: Colors.white,
                    ),

                    RawMaterialButton(
                      onPressed: (){
                        reset();
    },
                      fillColor: Colors.deepPurple,
                      shape: StadiumBorder(
                          side: BorderSide.none
                      ),
                      child: Text(
                        'RESET',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
      ),

    );
  }
}
