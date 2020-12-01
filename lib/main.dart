import 'package:flutter/material.dart';
import 'package:Krshi/splashscreen.dart';
import 'package:Krshi/Login.dart';

//import 'package:Krshi/dropdown.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => LoginPage()
      },
    ));
