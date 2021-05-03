import 'package:app_tecnomotriz_check_in_out_time/bloc/validator.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _qrCodeController = BehaviorSubject<String>();


  // Get values from the Stream
  Stream<String> get qrCodeStream =>
      _qrCodeController.stream.transform(validateQRCode);

  // Get value of the QR Code
  String get qrCode => _qrCodeController.value;

  set qrCode(String value) => _qrCodeController.add(value);

  dispose() {
    _qrCodeController?.close();
  }
}
