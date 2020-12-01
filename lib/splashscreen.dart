import 'package:flutter/material.dart';
//import './main.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                  Color(0xFF80DEEA),
                  Color(0xFFFFF59D),
                  Color(0xFFB3E5FC),
                  Color(0xFFFFCC80),
                ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ))),
            //   Container(
            //     height: 250,
            //  decoration: BoxDecoration(
            //        //position: DecorationPosition.background,
            //       image: DecorationImage(
            //      image : AssetImage("assets/farm.jpg",),
            //    fit: BoxFit.fitWidth,
            //    alignment: Alignment.topCenter,
            // ),
            //     ),),
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/farm1.jpg",
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/plant1.png',
                  ),
                  radius: 75,
                ),
                SizedBox(height: 40),
                CircularProgressIndicator(),
              ],
            ),
            // ),
            // Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Padding(
            //         padding: EdgeInsets.only(bottom: 40),
            //         child: Text('Intelligent Product Master',
            //       style: TextStyle(
            //         letterSpacing: 2.0,
            //         fontSize: MediaQuery.of(context).size.width/25,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.grey,
            //         fontFamily: 'Pacifico',
            //       )),)
            //       )
          ],
        ),
      ),
    );
  }
}
