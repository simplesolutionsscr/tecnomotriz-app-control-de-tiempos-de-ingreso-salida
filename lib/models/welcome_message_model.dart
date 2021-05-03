// To parse this JSON data, do
//
//     final WelcomeMessage = WelcomeMessageFromJson(jsonString);

import 'dart:convert';

WelcomeMessageModel welcomeMessageFromJson(String str) =>
    WelcomeMessageModel.fromJson(json.decode(str));

String welcomeMessageToJson(WelcomeMessageModel data) => json.encode(data.toJson());

class WelcomeMessageModel {
  WelcomeMessageModel({
    this.id,
    this.tipo,
    this.mensaje,
    this.estado,
  });

  String id;
  String tipo;
  String mensaje;
  String estado;

  factory WelcomeMessageModel.fromJson(Map<String, dynamic> json) => WelcomeMessageModel(
        id: json["Id"],
        tipo: json["Tipo"],
        mensaje: json["Mensaje"],
        estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Tipo": tipo,
        "Mensaje": mensaje,
        "Estado": estado,
      };
}
