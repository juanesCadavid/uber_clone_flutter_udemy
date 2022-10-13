import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.placa,
  });

  String id;
  String userName;
  String email;
  String password;
  String placa;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    password: json["password"],
    placa: json["placa"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email": email,
    "placa": placa,
  };
}
