import 'package:flutter/material.dart';

class DropdownPage extends StatefulWidget {
  DropdownPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  List<String> _data = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G"
  ]; //returned by first function farmer_data
  List<String> _data2 = ["T", "M", "I"]; //returned by second function
  List<String> _data3 = ["Z", "Y", "X", "W"]; //returned by third funtion

  List<String> _list = ["First", "Second", "Third"]; //representative name
  int index = 0;
  List<String> _list2 = ["Select Item"]; //farmer id
  int index2 = 0;
  List<String> _list3 = ["booking"]; // booking id
  int index3 = 0;
  List<String> _list4 = ["Select Item"]; //
  int index4 = 0;
  String plot_name = "", location = "", area = "";

  List<String> farmer_data(String representative) {
    //this will run a sql query
    return _data;
  }

  List<String> booking_id(String farmer_data) {
    //this will also return a sql query
    return _data2;
  }

  void get_plot_data(String booking_id) {
    //run sql query fetch that booking data from table in results; plot_name = results['']
    setState(() {
      plot_name = "abc";
      location = "UP";
      area = 'UP22';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(
              items: _list
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list[index],
              onChanged: (_) {
                print(_);
                setState(() {
                  _list2 = [];
                  _list2.addAll(farmer_data(_));
                });
                // based on selected value of representative name, function will be called
                //get_farmer_data(_) => list of farmer id => setState(() _list2
              }),
          DropdownButtonFormField(
              items: _list2
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list2[index2],
              onChanged: (_) {
                print(_);
                setState(() {
                  _list3 = [];
                  _list3.addAll(booking_id(_));
                });
              }),
          DropdownButtonFormField(
              items: _list3
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list3[index3],
              onChanged: (_) {
                print(_);
                setState(() {
                  plot_name = "abc";
                  location = "UP";
                  area = 'UP22';
                });
              }),
              Text(" PLot_Name = $plot_name"),
              Text("location = $location"),
              Text("area= $area"),
          // DropdownButtonFormField(
          //     items: _list4
          //         .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          //         .toList(),
          //     value: _list4[index4],
          //     onChanged: (_) {
          //       print(_);
          //     })
        ],
      ),
    ));
  }
}
