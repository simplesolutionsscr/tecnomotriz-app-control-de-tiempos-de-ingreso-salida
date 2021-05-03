import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Información Incorrecta',
            style: TextStyle(
              fontSize: 36,
              letterSpacing: 1.5,
              wordSpacing: 1,
            ),
          ),
          content: Text(message,
              style: TextStyle(
                fontSize: 28,
                letterSpacing: 1.5,
                wordSpacing: 1,
              )),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok',
                    style: TextStyle(
                      fontSize: 44,
                      letterSpacing: 1.5,
                      wordSpacing: 1,
                    )))
          ],
        );
      });
}

Widget createBackground(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final backgroundA = Container(
    height: size.height,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: <Color>[
          Color.fromRGBO(0, 0, 128, 0.8),
          Color.fromRGBO(0, 0, 179, 0.75),
        ],
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            tileMode: TileMode.repeated)),
  );
  return backgroundA;
  // final circle = Container(
  //   width: 100.0,
  //   height: 100.0,
  //   decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(100.0),
  //       color: Color.fromRGBO(255, 255, 255, 0.05)),
  // );
  // return Stack(
  //   children: <Widget>[
  //     backgroundA,
  //     Positioned(top: 90.0, left: 30.0, child: circle),
  //     Positioned(top: -40.0, right: -30.0, child: circle),
  //     Positioned(bottom: -50.0, right: -10.0, child: circle),
  //     Positioned(bottom: 120.0, right: 20.0, child: circle),
  //     Positioned(bottom: -50.0, left: -20.0, child: circle),
  //   ],
  // );
}
