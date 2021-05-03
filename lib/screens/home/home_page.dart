import 'dart:async';

import 'package:app_tecnomotriz_check_in_out_time/models/employee_model.dart';
import 'package:app_tecnomotriz_check_in_out_time/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timerDisplayer;

  /// This global private variable is to display for how many seconds the home page will be visible to the user
  static int _counter = 1;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _startTimerDisplayer();
    }
  }

  @override
  void dispose() {
    _timerDisplayer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeModel employeeModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        createBackground(context),
        _welcomeMessage(employeeModel),
      ],
    ));
  }

  // Widget _createBackground(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final backgroundA = Container(
  //     height: size.height,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //             colors: <Color>[
  //           Color.fromRGBO(63, 63, 156, 1.0),
  //           Color.fromRGBO(80, 70, 168, 0.85),
  //           Color.fromRGBO(90, 77, 178, 0.85),
  //         ],
  //             begin: Alignment.bottomLeft,
  //             end: Alignment.topLeft,
  //             tileMode: TileMode.repeated)),
  //   );

  //   // final circle = Container(
  //   //   width: 100.0,
  //   //   height: 100.0,
  //   //   decoration: BoxDecoration(
  //   //       borderRadius: BorderRadius.circular(100.0),
  //   //       color: Color.fromRGBO(255, 255, 255, 0.05)),
  //   // );
  //   // return Stack(
  //   //   children: <Widget>[
  //   //     backgroundA,
  //   //     Positioned(top: 90.0, left: 30.0, child: circle),
  //   //     Positioned(top: -40.0, right: -30.0, child: circle),
  //   //     Positioned(bottom: -50.0, right: -10.0, child: circle),
  //   //     Positioned(bottom: 120.0, right: 20.0, child: circle),
  //   //     Positioned(bottom: -50.0, left: -20.0, child: circle),
  //   //   ],
  //   // );
  // }

  Widget _tecnomotrizLogo(BuildContext context, double width, double height) {
    return SafeArea(
      child: Hero(
        tag: 1,
        child: Container(
          width: width * 0.85,
          child: Image.asset(
            'assets/img/LogoTecnomotrizsinEP.png',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            width: width * 0.4,
          ),
        ),
      ),
    );
  }

  Widget _welcomeMessage(EmployeeModel employeeModel) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String timeStamp = employeeModel.timeStamp;
    String id = 'IdEmpleado: ' + employeeModel.idEmpleado;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _tecnomotrizLogo(context, width, height),
          SizedBox(height: height * 0.025),
          _welcomeText('Chequeo de Tiempo Realizado Exitosamente'),
          SizedBox(height: height * 0.025),
          _employeeDataText(timeStamp),
          _employeeDataText(id),
          SizedBox(height: height * 0.025),
          _rederictingText(_counter.toString()),
        ],
      ),
    );
  }

  Widget _welcomeText(String text) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    TextStyle textStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 48,
        letterSpacing: 1.75,
        wordSpacing: 1.25);

    return Container(
        width: width * 0.85,
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text: text, style: textStyle)));
  }

  Widget _employeeDataText(String data) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        data,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 34,
            letterSpacing: 2.75,
            wordSpacing: 2.25),
      ),
    );
  }

  Widget _rederictingText(String text) {
    TextStyle textStyle = TextStyle(
        color: Colors.white,
        fontSize: 42,
        fontStyle: FontStyle.italic,
        letterSpacing: 2.75,
        wordSpacing: 2.25);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(style: textStyle, children: [
        TextSpan(text: 'Cerrando sesión en'),
        TextSpan(text: ' $text. ', style: textStyle),
        // TextSpan(text: 'segundos.')
      ])),
    );
  }

  void _startTimerDisplayer() {
    _timerDisplayer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timerDisplayer.cancel();
          _redirectToLogIn(context);
        }
      });
    });
  }

  void _redirectToLogIn(BuildContext context) {
    // Logout
    Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
  }
}
