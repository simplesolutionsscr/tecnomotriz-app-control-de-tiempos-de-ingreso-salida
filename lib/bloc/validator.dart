import 'dart:async';

class Validators {
  final validateQRCode =
      StreamTransformer<String, String>.fromHandlers(handleData: (qrCode, sink) {
    Pattern pattern =
        r'^[0-9]+$';
    RegExp regExp = new RegExp(pattern);
    (regExp.hasMatch(qrCode))
        ? sink.add(qrCode)
        : sink.addError('Código QR no es correcto.');
  });

}
