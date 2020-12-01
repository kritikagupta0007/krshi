import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:Krshi/logic/mysql.dart';
import 'package:Krshi/style/constants.dart';
import 'package:Krshi/registration.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RegistrationLogin extends StatefulWidget {
  @override
  _RegistrationLoginState createState() => _RegistrationLoginState();
}

enum FormType {
  login,
}

class _RegistrationLoginState extends State<RegistrationLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mail;
  String _password;
  FormType _formType = FormType.login;
  final FlutterTts flutterTts = FlutterTts();

  void speak(String text) async {
    await flutterTts.setLanguage("en_US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  bool validateandSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateandSubmited() async {
    if (validateandSave()) {
      authorize();
    }
  }

  var db = new Mysql();
  String authlist = "";

  void authorize() {
    print(_mail);
    print(_password);
    db.getConnection().then((conn) async {
      String sql = "Select mail, pass from register where mail = '$_mail'";
      await conn.query(sql).then((results) {
        for (var row in results) {
          print(row);
          if (row['mail'] == _mail && row['pass'].toString() == _password) {
            authlist = _mail;
          }
        }
      });
      if (authlist.length > 0) {
        speak("Hello, Here you can fill the entery of new farmer");
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new RegistrationForm()));
      } else {
        speak("Authorization failed!! Wrong username or password");
      }
      conn.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
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
                    // Color(0xFF73AEF5),
                    // Color(0xFF61A4F1),
                    // Color(0xFF478DE0),
                    // Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ))),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 110.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Admin Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        child: new Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          _buildEmailTF(),
                          SizedBox(height: 20.0),
                          _buildPasswordTF(),
                          SizedBox(height: 40.0),
                          _buildRegisterBtn()
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: new TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) =>
                value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _mail = value,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: new TextFormField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) =>
                value.isEmpty ? 'Password can\'t be empty' : null,
            onSaved: (value) => _password = value,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => validateandSubmited(),
        padding: EdgeInsets.all(25.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'REGISTRATION',
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
