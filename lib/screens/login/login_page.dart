import 'package:app_tecnomotriz_check_in_out_time/models/welcome_message_model.dart';
import 'package:app_tecnomotriz_check_in_out_time/provider/welcome_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:app_tecnomotriz_check_in_out_time/bloc/login.dart';
import 'package:app_tecnomotriz_check_in_out_time/provider/employee_provider.dart';
import 'package:app_tecnomotriz_check_in_out_time/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final employeeProvider = new EmployeeProvider();
  final welcomeMessageProvider = new WelcomeMessageProvider();
  String _message;
  bool _showOnlineWelcomeMessage = false;

  static const TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 64,
      letterSpacing: 1.75,
      wordSpacing: 1.25);

  LoginBloc _bloc = new LoginBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          createBackground(context),
          _loginForm(context, _bloc),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context, LoginBloc bloc) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _tecnomotrizLogo(orientation, width, height),
              SizedBox(
                height: height * 0.02,
              ),
              _animatedCrossFade(),
              SizedBox(
                height: height * 0.02,
              ),
              _typeOfTimeRegistration(orientation, bloc, width, height)
            ],
          ),
        ),
      ),
    );
  }

  Widget _tecnomotrizLogo(
      Orientation orientation, double width, double height) {
    return Hero(
      tag: 1,
      child: SafeArea(
        child: Container(
          width: (orientation == Orientation.portrait)
              ? width * 0.85
              : width * 0.5,
          child: Image.asset(
            'assets/img/LogoTecnomotrizsinEP.png',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            width: width * 0.5,
          ),
        ),
      ),
    );
  }

  AnimatedCrossFade _animatedCrossFade() {
    return AnimatedCrossFade(
      crossFadeState: _showOnlineWelcomeMessage
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      firstCurve: Curves.easeOutBack,
      secondCurve: Curves.easeInOut,
      sizeCurve: Curves.easeIn,
      firstChild: _welcomeText(),
      secondChild: _welcomeText(),
    );
  }

  FutureBuilder _welcomeText() {
    return FutureBuilder(
        future: _getWelcomeMessage(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _welcomeMessage('¡Bienvenido!');
          } else {
            return _connectionStateWidget(snapshot);
          }
        });
  }

  Container _connectionStateWidget(AsyncSnapshot<dynamic> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        print('ConnectionState waiting.');
        return _welcomeMessage('¡Bienvenido!');
      case ConnectionState.active:
        print('ConnectionState active.');
        return _welcomeMessage('¡Bienvenido!');
      case ConnectionState.none:
        print('ConnectionState none.');
        return _welcomeMessage('¡Bienvenido!');
      case ConnectionState.done:
        print('ConnectionState done.');
        _showOnlineWelcomeMessage = true;
        return _welcomeMessage(snapshot.data);
    }
  }

  Container _welcomeMessage(String message) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        width: width * 0.85,
        padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 12.0),
        alignment: Alignment.center,
        child: Text(
          message,
          // softWrap: false,
          overflow: TextOverflow.visible,
          textScaleFactor: _getTextScaleFactor(message),
          //0.45,
          textAlign: TextAlign.center,
          style: _textStyle,
        ));
  }

  double _getTextScaleFactor(String message) {
    if (message.length < 50) return 1;
    if (message.length < 100) return 0.8;
    if (message.length < 150) return 0.6;
    if (message.length == 280) return 0.45;
  }

  Widget _typeOfTimeRegistration(
      Orientation orientation, LoginBloc bloc, double width, double height) {
    Widget w;

    List<Widget> widgetList = [
      // Entry
      _loginQRCodeButton(
          orientation, bloc, width, height, Icons.login, 'Entrada'),
      // Break/Finish Work Day and related time checks
      _loginQRCodeButton(
          orientation, bloc, width, height, Icons.logout, 'Salida'),
      // Special Request
      _loginQRCodeButton(
          orientation, bloc, width, height, Icons.assignment, 'Permiso'),
    ];

    (orientation == Orientation.portrait)
        ? w = Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widgetList)
        : w = Row(
            verticalDirection: VerticalDirection.up,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widgetList,
          );
    return Container(
      height: height * 0.4,
      // color: Colors.white,
      child: w,
    );
  }

  StreamBuilder _loginQRCodeButton(Orientation orientation, LoginBloc bloc,
      double width, double height, IconData icon, String bottonAction) {
    bool o = orientation == Orientation.portrait;
    return StreamBuilder(
        stream: bloc.qrCodeStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return o
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: ElevatedButton(
                      onPressed: (!snapshot.hasData)
                          ? () => _login(bloc, context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.blue,
                        elevation: 10.0,
                      ),
                      child: Container(
                          width: height * 0.35,
                          height: height * 0.1,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon,
                                color: Colors.white,
                                size: 72,
                                semanticLabel: 'Escanear Código QR',
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                bottonAction,
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 44),
                              )
                            ],
                          ))))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                        onPressed: (!snapshot.hasData)
                            ? () => _login(bloc, context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          elevation: 10.0,
                        ),
                        child: Container(
                          width: height * 0.3,
                          height: height * 0.3,
                          alignment: Alignment.center,
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.blue,
                          //     gradient: LinearGradient(
                          //       begin: Alignment.topCenter,
                          //       end: Alignment.bottomCenter,
                          //       colors: [
                          //         Colors.blue[500],
                          //         Colors.blue[700],
                          //       ],
                          //     )),
                          child: Icon(
                            icon,
                            size: 130,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: (!snapshot.hasData)
                    //       ? () => _login(bloc, context)
                    //       : null,
                    //   child: Container(
                    //       margin: EdgeInsets.only(bottom: 15),
                    //       height: height * 0.3,
                    //       width: height * 0.3,
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           //   color: Colors.blue,
                    //           // ),
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               Colors.blue[500],
                    //               Colors.blue[700],
                    //             ],
                    //           )),
                    //       child: Icon(
                    //         icon,
                    //         color: Colors.white,
                    //         size: 130,
                    //       )),
                    // ),
                    // ),
                    Text(bottonAction,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            letterSpacing: 3.5))
                  ],
                );
        });
  }

  Future<String> _getWelcomeMessage() async {
    Map<String, dynamic> message =
        await welcomeMessageProvider.getWelcomeMessage();
    WelcomeMessageModel messageModel = message['message'];

    return messageModel.mensaje;
    // return "ifqk9MwVqcpbLbs6n5lQz1kOGaz66UUgweoPYcB2C8Kfh4IF77yMwKG0heFBmZLqLPfff9Dztg7cmXkVAIIKfYL1DVBnuaN1S7gq5wY7IQLx46RTlIKZDeNXd3VVf6OpU3KZfXqMG55ZjjYQmDfNHWtcnmzgK1AGIu3aJFrG5XNtPy6ukNtMmMJlPlpcDONxRqwmBv0Aco3c0i2c2naZ9gHij0DfYkeQVh5pE28sv6Ctu3aVnVsJpJELvo2if4dQM6t9M6adF63kdSXBzv1Z48yw";
  }

  void _login(LoginBloc bloc, BuildContext context) async {
    bool readCode = await _scanQRCode(bloc);

    if (readCode) {
      Map<String, dynamic> info =
          await employeeProvider.loginQRCode(bloc.qrCode);

      if (!info['error']) {
        Navigator.pushReplacementNamed(context, 'home',
            arguments: info['employee']);
      } else {
        showAlert(context, info['message']);
      }
    } else {
      String message =
          'El escaneo del Código QR fue cancelado antes de detectar un Código QR.\n\nPor favor, intentar la lectura de un Código QR de nuevo.';
      showAlert(context, message);
    }
  }

  Future<bool> _scanQRCode(LoginBloc bloc) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3D8BEF', 'Cancelar', false, ScanMode.QR);
    if (barcodeScanRes == '-1') {
      return false;
    }
    _bloc.qrCode = barcodeScanRes;
    return true;
  }
}
