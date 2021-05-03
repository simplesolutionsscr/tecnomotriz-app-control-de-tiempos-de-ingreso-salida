import 'package:app_tecnomotriz_check_in_out_time/screens/home/home_page.dart';
import 'package:app_tecnomotriz_check_in_out_time/screens/login/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tecnomotriz Control Ingreso',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      routes: {
        // '/': (BuildContext context) => MainPage(),
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}
