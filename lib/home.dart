import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Krshi/logic/mysql.dart';
//import 'package:date_format/date_format.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  var selectedType;
  var plot = new List();
  var db = new Mysql();
  List<String> _accountType = <String>[
    'Savings',
    'Deposit',
    'Checking',
    'Brokerage'
  ];
  String farm;
  Future<List> _farm(String farm) {
    plot.clear();
    print("Before");
    print('$farm');
    print("After");
    db.getConnection().then((conn) async {
      String sql = "Select * from plot_data where farmer_ID ='$farm'";
      await conn.query(sql).then((results) {
        for (var row in results) {
          print(row);
          if (row['farmer_ID'] == farm) {
            print(row['booking_ID']);
            plot.add(row['booking_ID']);
        }
        }
        print(plot);
      });
      conn.close();
    });
  }

void clear_data(String text){
  if (text.length == 0){
    plot.clear();
  }
}

  Widget _drop(){
    return  DropdownButton(
                    items: _accountType
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (_accountType) {
                      print('$_accountType');
                      final snackBar = SnackBar(
                        backgroundColor: Colors.black,
                        content: Text('Selected Crop name is $_accountType',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      );
                      Scaffold.of(context).showSnackBar((snackBar));
                      setState(() {
                        selectedType = _accountType;
                      });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text(
                      'Choose Crop Type',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  );
  }

  Future<Widget> _dynamicdrop(List<dynamic> data) async{
    return  DropdownButton(
                    items: data
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (datas) {
                      print('$datas');
                      final snackBar = SnackBar(
                        backgroundColor: Colors.black,
                        content: Text('Selected Crop name is $datas',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      );
                      Scaffold.of(context).showSnackBar((snackBar));
                      setState(() {
                        selectedType = datas;
                      });
                    },
                    value: selectedType,
                    isExpanded: false,
                    hint: Text(
                      'Choose Booking ID',
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  );
  }

  //  void authorit(){
  //   db.getConnection().then((conn) async {
  //     String sql = "Select cropname from Cropname";
  //     await conn.query(sql).then((results) {
  //       for (var row in results) {
  //         print(row);
  //         }

  //       }
  //     );
  //     conn.close();
  //   });
  // }

  DateTime _currentdate = new DateTime.now();
  DateTime _repodate = new DateTime.now();

  // Future<DateTime> _selectdate(BuildContext context) async{
  //     final DateTime _seldate = await showDatePicker(
  //       context: context,
  //       initialDate: _currentdate,
  //       firstDate: DateTime(1990),
  //       lastDate: DateTime(2022),
  //       builder: (context,child) {
  //         return SingleChildScrollView(child: child,);
  //       }
  //     );
  //     if(_seldate!=null) {
  //       setState(() {
  //         _currentdate = _seldate;
  //       });
  //     }
  // }

  Future<DateTime> _choosedate(BuildContext context) async {
    final DateTime _chdate = await showDatePicker(
        context: context,
        initialDate: _repodate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2022),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              //primarySwatch: Color.,
              primaryColor: Color(0xFF76FF03),
              accentColor: Color(0xFF76FF03),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme
                      .accent //color of the text in the button "OK/CANCEL"
                  ),
            ),
            child: child,
          );
        });
    if (_chdate != null) {
      setState(() {
        _repodate = _chdate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1B5E20),
            elevation: 20.0,
            toolbarHeight: 80.0,
            leading: IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {},
            ),
            title: Container(
              alignment: Alignment.center,
              child: Text("KRSHI",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            actions: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/plant1.png',
                  ),
                  radius: 30,
                ),
              ),
            ],
          ),
          body: Stack(children: <Widget>[
            Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFCCFF90),
                    Color(0xFFCCFF90),
                    Color(0xFFB2FF59),
                    Color(0xFF76FF03),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ))),
            Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 90.0,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Form(
                          key: _formKeyValue,
                          autovalidate: true,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                _dateandTime(),
                                _reportdate(),
                                _representative(),
                                _cropname(),
                                _farmerID(),
                                _bookingID(),
                               // _plotNum(),
                                _cropStage(),
                                _mainActivity(),
                                _taskName(),
                                _machinery(),
                                _quantity(),
                                _unit(),
                                _runningHours(),
                                _dieselQty(),
                              ]),
                        ))
                      ]),
                )),
          ])),
    );
  }

  Widget _dateandTime() {
    String _formattedate =
        new DateFormat('MM-dd-yyyy / kk:mm:a').format(_currentdate);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Date and Time',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$_formattedate',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ]),
    );
  }

  Widget _reportdate() {
    String _formatedate = new DateFormat.yMMMd().format(_repodate);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Report Date',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _formatedate == null ? '' : _formatedate.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    _choosedate(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.calendarCheck,
                    size: 40,
                    color: Colors.green[800],
                  ),
                ),
              ]),
        ));
  }

  String selectedrepresentate;
  Widget _representative() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("representative").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text("Loading.....");
              else {
                List<DropdownMenuItem> representItems = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  //print(snap.documentID);
                  representItems.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.documentID,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: "${snap.documentID}",
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Representative',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          elevation: 100,
                          items: representItems,
                          onChanged: (representative) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                  'Select the Representative $representative',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selectedrepresentate = representative;
                            });
                          },
                          value: selectedrepresentate,
                          isExpanded: false,
                          hint: new Text(
                            "Select the Representative",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  String selectedCropname;
  Widget _cropname() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Crop Number',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 50.0),
                 _drop(),
                ])));
  }

  Widget _farmerID() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Farmer ID',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
              width: 150,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: new TextFormField(
                  textAlign: TextAlign.center,
                  //textAlignVertical: TextAlignVertical.center,
                  onFieldSubmitted: (text) {
                    print(text);
                    clear_data(text);
                    print("onsubmitted");
                    //farm = value.trim();
                    _farm(text);
                  },
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.filter_frames, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      value.isEmpty ? 'Email can\'t be empty' : null,
                  onSaved: (value) => farm = value.trim(),
                ),
              )),
        ],
      ),
    );
  }

  Widget _bookingID() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Booking ID',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20, ),
          
          // _dynamicdrop(plot),
          // Container(
          //     width: 150,
          //     height: 30,
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //         left: 20,
          //       ),
          //       child: new TextFormField(
          //         textAlign: TextAlign.center,
          //         textAlignVertical: TextAlignVertical.center,
          //         decoration: InputDecoration(
          //           hoverColor: Colors.white,
          //           filled: true,
          //           fillColor: Colors.white,
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(20.0)),
          //         ),
          //         keyboardType: TextInputType.number,
          //       ),
          //     )),
        ],
      ),
    );
  }

  // String selectedplot;
  // Widget _plotNum() {
  //   return Column(
  //     children: [
  //       FutureBuilder<List>(
  //           future: _farm('RA001'),
  //           builder: (BuildContext, AsyncSnapshot<List<dynamic>> snapshot) {
  //             if (!snapshot.hasData) return Text("Loading.....");
  //             return DropdownButton(
  //               elevation: 100,
  //               items: snapshot.data
  //                   .map((text) => DropdownMenuItem<dynamic>(
  //                         child: Text(
  //                           text,
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 20.0,
  //                           ),
  //                         ),
  //                         value: text,
  //                       ))
  //                   .toList(),
  //               onChanged: (plotnum) {
  //                 final snackBar = SnackBar(
  //                   backgroundColor: Colors.black,
  //                   content: Text('Selected Crop name is $plotnum',
  //                       style: TextStyle(color: Colors.white, fontSize: 18.0)),
  //                 );
  //                 Scaffold.of(context).showSnackBar(snackBar);
  //                 setState(() {
  //                   selectedplot = plotnum;
  //                 });
  //               },
  //               value: selectedplot,
  //               isExpanded: false,
  //               hint: new Text(
  //                 "Choose Plot Number",
  //                 style: TextStyle(color: Colors.black, fontSize: 20.0),
  //               ),
  //             );

  //             // else {
  //             //   List<DropdownMenuItem> plotList = [];
  //             //   for (int i = 0; i < snapshot.data.documents.length; i++) {
  //             //     DocumentSnapshot snap2 = snapshot.data.documents[i];
  //             //     plotList.add(
  //             //       DropdownMenuItem(
  //             //         child: Text(
  //             //           snap2.documentID,
  //             //           style: TextStyle(
  //             //             color: Colors.black,
  //             //             fontSize: 20.0,
  //             //           ),
  //             //         ),
  //             //         value: "${snap2.documentID}",
  //             //       ),
  //             //     );
  //             //   }
  //             //   return Padding(
  //             //     padding: const EdgeInsets.all(10.0),
  //             //     child: SingleChildScrollView(
  //             //       scrollDirection: Axis.horizontal,
  //             //       child: Row(
  //             //         crossAxisAlignment: CrossAxisAlignment.center,
  //             //         children: <Widget>[
  //             //           Text(
  //             //             'Plot Number',
  //             //             style: TextStyle(
  //             //               fontSize: 20.0,
  //             //               fontWeight: FontWeight.bold,
  //             //             ),
  //             //           ),
  //             //           SizedBox(width: 50.0),
  //             //           DropdownButton(
  //             //             elevation: 100,
  //             //             items: plotList,
  //             //             onChanged: (plotnum) {
  //             //               final snackBar = SnackBar(
  //             //                 backgroundColor: Colors.black,
  //             //                 content: Text('Selected Crop name is $plotnum',
  //             //                     style: TextStyle(
  //             //                         color: Colors.white, fontSize: 18.0)),
  //             //               );
  //             //               Scaffold.of(context).showSnackBar(snackBar);
  //             //               setState(() {
  //             //                 selectedplot = plotnum;
  //             //               });
  //             //             },
  //             //             value: selectedplot,
  //             //             isExpanded: false,
  //             //             hint: new Text(
  //             //               "Choose Plot Number",
  //             //               style:
  //             //                   TextStyle(color: Colors.black, fontSize: 20.0),
  //             //             ),
  //             //           ),
  //             //         ],
  //             //       ),
  //             //     ),
  //             //   );
  //           }),
  //     ],
  //   );
  // }

  String selectedcropstage;
  Widget _cropStage() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("cropstage").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text("Loading.....");
              else {
                List<DropdownMenuItem> cropList = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  cropList.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.documentID,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: "${snap.documentID}",
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Crop Stage',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          elevation: 100,
                          items: cropList,
                          onChanged: (cropstage) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.black,
                              content: Text('Selected Crop name is $cropstage',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                            );
                            Scaffold.of(context).showSnackBar((snackBar));
                            setState(() {
                              selectedcropstage = cropstage;
                            });
                          },
                          value: selectedcropstage,
                          isExpanded: false,
                          hint: new Text(
                            "Choose Crop Stage",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  String selectedMainActivity;
  Widget _mainActivity() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("mainactivity").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text("Loading.....");
              else {
                List<DropdownMenuItem> activityList = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  activityList.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.documentID,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: "${snap.documentID}",
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Main Activity',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          elevation: 100,
                          items: activityList,
                          onChanged: (mainactivity) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                  'Selected Activity is $mainactivity',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                            );
                            Scaffold.of(context).showSnackBar((snackBar));
                            setState(() {
                              selectedMainActivity = mainactivity;
                            });
                          },
                          value: selectedMainActivity,
                          isExpanded: false,
                          hint: new Text(
                            "Select Main Activity",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  String selectedTaskName;
  Widget _taskName() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("taskname").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text("Loading.....");
              else {
                List<DropdownMenuItem> taskList = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  taskList.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.documentID,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: "${snap.documentID}",
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Task Name',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          elevation: 100,
                          items: taskList,
                          onChanged: (taskname) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.black,
                              content: Text('Selected Task name is $taskname',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                            );
                            Scaffold.of(context).showSnackBar((snackBar));
                            setState(() {
                              selectedTaskName = taskname;
                            });
                          },
                          value: selectedTaskName,
                          isExpanded: false,
                          focusColor: Colors.white,
                          hint: new Text(
                            "Choose Crop Stage",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  String selectedMachinery;
  Widget _machinery() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("machinery").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text("Loading.....");
              else {
                List<DropdownMenuItem> machineList = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  machineList.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.documentID,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      value: "${snap.documentID}",
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Machinery Used',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          elevation: 100,
                          items: machineList,
                          onChanged: (machine) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.black,
                              content: Text('Selected Machine name is $machine',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                            );
                            Scaffold.of(context).showSnackBar((snackBar));
                            setState(() {
                              selectedMachinery = machine;
                            });
                          },
                          value: selectedMachinery,
                          isExpanded: false,
                          hint: new Text(
                            "Machinery Used",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  Widget _quantity() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Quantity',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 70.0,
          ),
          Container(
              width: 150,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: new TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              )),
        ],
      ),
    );
  }

  Widget _unit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Unit    ',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 90.0,
          ),
          Container(
              width: 150,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: new TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  keyboardType: TextInputType.text,
                ),
              )),
        ],
      ),
    );
  }

  Widget _runningHours() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Running Hours',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
              width: 150,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: new TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              )),
        ],
      ),
    );
  }

  Widget _dieselQty() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Desel Qty',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 60.0,
          ),
          Container(
              width: 150,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: new TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  keyboardType: TextInputType.number,
                ),
              )),
        ],
      ),
    );
  }
}
