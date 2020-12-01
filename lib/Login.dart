import 'package:flutter/material.dart';
import 'package:Krshi/main.dart';
import 'package:Krshi/registration.dart';
import 'package:Krshi/logic/mysql.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:Krshi/home.dart';
import 'package:Krshi/style/constants.dart';
import 'package:Krshi/registrationlogin.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPage({Key key}) : super(key: key);
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  final FlutterTts flutterTts = FlutterTts();

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
    print(_email);
    print(_password);
    db.getConnection().then((conn) async {
      String sql = "Select email, pass from login where email = '$_email'";
      await conn.query(sql).then((results) {
        for (var row in results) {
          print(row);
          if (row['email'] == _email && row['pass'].toString() == _password) {
            authlist = _email;
          }
        }
      });
      if (authlist.length > 0) {
        speak("Hello user, welcome to our app kreshi");
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new FormPage()));
      } else {
        speak("Authorization failed!! Wrong username or password");
      }
      conn.close();
    });
  }

  void speak(String text) async {
    await flutterTts.setLanguage("en_US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
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
                  vertical: 80.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //       CircleAvatar(
                    // backgroundImage: AssetImage('assets/plant1.png',),
                    // radius: 75,),
                    Text(
                      "Sign",
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
                            height: 30.0,
                          ),
                          _buildEmailTF(),
                          SizedBox(height: 20.0),
                          _buildPasswordTF(),
                          SizedBox(height: 15.0),
                          // _buildForgotPasswordBtn(),
                          _buildLoginBtn(),
                          SizedBox(height: 40.0),
                          _buildText(),
                          _buildRegisterBtn(),
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
            onSaved: (value) => _email = value,
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
              // border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(10.0),
              //     borderSide:
              //         BorderSide(color: Colors.greenAccent, width: 3.0)),
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => validateandSubmited(),
        // {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (BuildContext context) => FormPage()));
        // },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RegistrationLogin()));
        },
        padding: EdgeInsets.all(20.0),
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

  Widget _buildText() {
    return Center(
      child: Text(
        'Registration is done only by the Admin',
        style: kLabelStyle,
      ),
    );
  }
}
