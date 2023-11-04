// import 'dart:convert';
//
// AadharModel AadharModelFromJson(String str) =>
//     AadharModel.fromJson(json.decode(str));
//
// String AadharModelToJson(AadharModel data) => json.encode(data.toJson());
//
class AadharModel {
  String? AadharNumber;
  String? password;

  AadharModel({
    required this.AadharNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "AadharNumber": AadharNumber,
        "password": password,
      };

  factory AadharModel.fromJson(Map<String, dynamic> json) => AadharModel(
        AadharNumber: json["AadharNumber"],
        password: json["password"],
      );
}
//
//
// }
