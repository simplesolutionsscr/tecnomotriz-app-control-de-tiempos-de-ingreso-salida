import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) =>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  EmployeeModel({
    this.idEmpleado,
    this.timeStamp,
    this.idTipoRegistroTiempo,
    this.estado,
  });

  String idEmpleado;
  String timeStamp;
  String idTipoRegistroTiempo;
  String estado;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        idEmpleado: json['IdEmpleado'],
        timeStamp: json["TimeStamp"],
        idTipoRegistroTiempo: json["IdTipoRegistroTiempo"],
        estado: json["Etado"],
      );

  Map<String, dynamic> toJson() => {
        'IdEmpleado': idEmpleado,
        'TimeStamp': timeStamp,
        'IdTipoRegistroTiempo': idTipoRegistroTiempo,
        'Estado': estado
      };
}
