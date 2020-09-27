import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
  fontSize: 15.0,
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 16.0,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xff64DD17),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
