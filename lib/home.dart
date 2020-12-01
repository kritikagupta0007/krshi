import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Krshi/logic/mysql.dart';
import 'package:Krshi/style/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormPage extends StatefulWidget {
  @override
  FormPage({Key key}) : super(key: key);
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  var plot = new List();
  var db = new Mysql();

  List<String> _list = ["Select Representative"]; //representative name
  int index = 0;
  List<String> _list2 = ["Select the Farmers ID"]; //farmer id
  int index2 = 0;
  List<String> _list3 = ["Select the Booking ID"]; // booking id
  int index3 = 0;
  List<String> _list4 = ["Select the Crop Name"]; //
  int index4 = 0;
  List<String> _list5 = ["Select the Crop Stage"]; //
  int index5 = 0;
  List<String> _list6 = ["Select the Main Activity"]; //
  int index6 = 0;
  List<String> _list7 = ["Select the Machinery"]; //
  int index7 = 0;

  String plot_name = "", location = "";
  double area;

  String _repoDate = "",
      _datetime = "",
      _bookingiD = "",
      cropname = "",
      cropstage = "",
      mainactivity = "",
      machinery = "",
      _qty = "",
      _unit1 = "",
      _runninghrs = "",
      _dieselqty = "",
      _dieselvalue = "",
      _manPower = "",
      _mannum = "",
      _totalhr = "",
      _remarks = "";

  //returned by first function farmer_data
  //List<String> _data2 = []; //returned by second function//returned by third funtion

  void save_data_to_database() {
    // print("Filing date = " + _datetime);
    // print("Report date = " + _repoDate);
    // print("Booking ID = " + _bookingiD);
    // print('cropname ' + cropname);
    // print("cropstage " + cropstage);
    // print("diesel =" + _dieselqty);
    // print("remark = " + _remarks);
    db.getConnection().then((conn) async {
      String sql =
          "INSERT INTO save_data VALUES('$_datetime', '$_repoDate', '$_bookingiD', '$cropname', '$cropstage', '$mainactivity', '$machinery', '$_qty', '$_unit1', '$_runninghrs', '$_dieselqty','$_dieselvalue', '$_manPower', '$_mannum', '$_totalhr','$_remarks')";
      await conn.query(sql).then((results) {
        print("Done!!");
      });
    });
  }

  List<String> data2 = [];
  Future<List<String>> representative_data() async {
    setState(() {
      _list2 = ["Select Farmer ID"];
      _list3 = ["Select Booking ID"];
    });
    db.getConnection().then((conn) async {
      String sql = "SELECT representative_name FROM representative";
      await conn.query(sql).then((results) {
        // var responseJson = json.decode(utf8.decode(results.bodyBytes));
        for (var row in results) {
          //yha shyd data 2 me translator lgega haan ruko main dekhta
          // print(row['representative_name'].translate(to: 'hi'));
          data2.add(row['representative_name']);
        }
      });
      print("representative is = ");
      print(data2);
    });
    return data2;
  }

  List<String> data = [];
  Future<List<String>> farmer_data(String representative) async {
    setState(() {
      data = [];
    });
    //_data2 = [];//
    //this will run a sql query
    db.getConnection().then((conn) async {
      String sql =
          "SELECT farmer_ID FROM farmer_data where representative_ID = (SELECT representative_ID FROM representative WHERE representative_name='$representative')";
      await conn.query(sql).then((results) {
        for (var row in results) {
          data.add(row['farmer_ID']);
        }
        setState(() {
          _list2 = ["Select your Farmer ID"];
          _list2.addAll(data);
        });
        print("Data inside function is = ");
        print(_list2);
      });
    });
  }

  Future<List<String>> booking_id(String farmer_ID) async {
    List<String> data1 = [];
    //this will also return a sql query
    db.getConnection().then((conn) async {
      String sql =
          "Select booking_ID from plot_data where farmer_ID ='$farmer_ID'";
      await conn.query(sql).then((results) {
        for (var row in results) {
          data1.add(row['booking_ID']);
        }
        setState(() {
          _list3 = ["Select your Booking ID"];
          _list3.addAll(data1);
        });
        print("Data inside function is = ");
        print(data1);
      });
    });
  }

  Future<List<String>> booking_data(String booking_ID) async {
    db.getConnection().then((conn) async {
      String sql = "Select * from plot_data where booking_ID ='$booking_ID'";
      await conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            location = row['location'];
            area = row['area'];
          });
        }
      });
    });
  }

  List<String> data3 = [];
  Future<List<String>> _crop_name() async {
    db.getConnection().then((conn) async {
      String sql = "Select cropname from cropname ";
      await conn.query(sql).then((results) {
        for (var row in results) {
          data3.add(row['cropname']);
        }
        setState(() {
          _list4 = ["Select your Crop Name"];
          _list4.addAll(data3);
        });
        print("Crop is = ");
        print(data3);
      });
    });
  }

  Future<List<String>> crop_stage() async {
    List<String> data4 = [];
    db.getConnection().then((conn) async {
      String sql = "Select crop_stage from cropstage ";
      await conn.query(sql).then((results) {
        for (var row in results) {
          data4.add(row['crop_stage']);
        }
        setState(() {
          _list5 = ["Select your Crop Stage"];
          _list5.addAll(data4);
        });
        print("Crop stage is = ");
        print(data4);
      });
    });
  }

  Future<List<String>> main_activity() async {
    List<String> data5 = [];
    db.getConnection().then((conn) async {
      String sql = "Select mainactivity from mainactivity ";
      await conn.query(sql).then((results) {
        for (var row in results) {
          data5.add(row['mainactivity']);
        }
        setState(() {
          _list6 = ["Select your Main Activity"];
          _list6.addAll(data5);
        });
        print("Main activity is = ");
        print(data5);
      });
    });
  }

  Future<List<String>> machinary_used() async {
    List<String> data6 = [];
    db.getConnection().then((conn) async {
      String sql = "Select machinery_used from machinery_used ";
      await conn.query(sql).then((results) {
        for (var row in results) {
          data6.add(row['machinery_used']);
        }
        setState(() {
          _list7 = ["Select Machine Used"];
          _list7.addAll(data6);
        });
        print("Machine is = ");
        print(data6);
      });
    });
  }

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
  void initState() {
    super.initState();
    representative_data();
    _crop_name();
    crop_stage();
    main_activity();
    machinary_used();
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
                          //autovalidate: true,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                _dateandTime(),
                                _reportdate(),
                                SizedBox(height: 10),
                                _bookingID(),
                                _cropStage(),
                                SizedBox(height: 5),
                                _quantity(),
                                _unit(),
                                _runningHours(),
                                _dieselQty(),
                                _dieselvalu(),
                                _manpower(),
                                _manpowernum(),
                                _totalhrs(),
                                _remark(),
                                _buildsubmitBtn()
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
    _datetime = _formattedate;
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
    _repoDate = _formatedate;
    return Padding(
        padding: const EdgeInsets.all(8.0),
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
                        color: Color(0xFFB2FF59),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _formatedate == null ? '' : _formatedate.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    _choosedate(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.calendarWeek,
                    size: 40,
                    color: Colors.green[800],
                  ),
                ),
              ]),
        ));
  }

  Widget _bookingID() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Repersentative Name",
              ),
              style: kLabelStyle,
              onTap: () async {
                print("hi $data2");
                try {
                  _list = ["Select Representative"];
                  setState(() {
                    _list.addAll(data2);
                  });
                } catch (e) {
                  print(e.message);
                }
              },
              items: _list
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list[index],
              onChanged: (_) async {
                print(_);
                farmer_data(_);
              }),
          SizedBox(height: 22),
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Farmers ID",
              ),
              style: kLabelStyle,
              items: _list2
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list2[index2],
              onChanged: (_) async {
                print(_);
                booking_id(_);
              }),
          SizedBox(height: 22),
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Booking ID",
              ),
              style: kLabelStyle,
              items: _list3
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list3[index3],
              onChanged: (_) async {
                print(_);
                _bookingiD = _;
                booking_data(_);
              }),
          SizedBox(height: 15),
          Text(
            "Location $location",
            style: kLabelStyle,
          ),
          SizedBox(height: 15),
          Text(
            "Area $area",
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _cropStage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Crop Name",
              ),
              style: kLabelStyle,
              items: _list4
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list4[index4],
              onChanged: (_) {
                print(_);
                cropname = _;
                setState(() {
                  crop_stage();
                });
              }),
          SizedBox(height: 22),
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Crop Stage",
              ),
              style: kLabelStyle,
              items: _list5
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list5[index5],
              onChanged: (_) {
                print(_);
                cropstage = _;
                main_activity();
              }),
          SizedBox(height: 22),
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Main Activity Perform",
              ),
              style: kLabelStyle,
              items: _list6
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list6[index6],
              onChanged: (_) {
                print(_);
                mainactivity = _;
                machinary_used();
              }),
          SizedBox(height: 22),
          DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDense: true,
                labelText: "Machinery",
              ),
              style: kLabelStyle,
              items: _list7
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _list7[index7],
              onChanged: (_) {
                print(_);
                machinery = _;
              })
        ],
      ),
    );
  }

  Widget _quantity() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Quantity', style: kLabelStyle),
          // SizedBox(
          //   width: 78.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Quantity"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _qty = value;
                      print(_qty);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _unit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Unit    ', style: kLabelStyle),
          // SizedBox(
          //   width: 90.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Unit"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _unit1 = value;
                      print(_unit1);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _runningHours() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Running Hours', style: kLabelStyle),
          // SizedBox(
          //   width: 30.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Running Hours"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _runninghrs = value;
                      print(_runninghrs);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _dieselQty() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Desel Qty', style: kLabelStyle),
          // SizedBox(
          //   width: 65.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Diesel Quantity"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _dieselqty = value;
                      print(_dieselqty);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _dieselvalu() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Desel Value', style: kLabelStyle),
          // SizedBox(
          //   width: 52.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Diesel Value"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _dieselvalue = value;
                      print(_dieselvalue);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _manpower() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Man Power', style: kLabelStyle),
          // SizedBox(
          //   width: 55.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Man Power"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _manPower = value;
                      print(_manPower);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _manpowernum() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Man Power Number', style: kLabelStyle),
          // SizedBox(
          //   width: 5.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Man Power Number"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _mannum = value;
                      print(_mannum);
                    });
                  })),
        ],
      ),
    );
  }

  Widget _totalhrs() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Total Hours', style: kLabelStyle),
          // SizedBox(
          //   width: 60.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: new TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Total Time"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _totalhr = value;
                      print("yes $_totalhr");
                    });
                  })),
        ],
      ),
    );
  }

  Widget _remark() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('Remark', style: kLabelStyle),
          // SizedBox(
          //   height: 18.0,
          // ),
          Container(
              alignment: Alignment.centerLeft,
              height: 90.0,
              child: new TextFormField(
                  maxLines: 20,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      isDense: true,
                      labelText: "Remark"),
                  style: kLabelStyle,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _remarks = value;
                      print("re $_remarks");
                    });
                  })),
        ],
      ),
    );
  }

  void save_data() {
    save_data_to_database();
    alertbox(context);
  }

  void alertbox(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Form is saved Successfully'),
      content: Text('Thank You for filing the form'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Widget _buildsubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          save_data();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SUBMIT',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
