import 'dart:convert';

OtpVerifyResp otpVerifyRespFromJson(String str) => OtpVerifyResp.fromJson(json.decode(str));

String otpVerifyRespToJson(OtpVerifyResp data) => json.encode(data.toJson());

class OtpVerifyResp {
  String? status;
  Data? data;

  OtpVerifyResp({
    this.status,
    this.data,
  });

  factory OtpVerifyResp.fromJson(Map<String, dynamic> json) => OtpVerifyResp(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  bool? acknowledged;
  int? modifiedCount;
  dynamic upsertedId;
  int? upsertedCount;
  int? matchedCount;

  Data({
    this.acknowledged,
    this.modifiedCount,
    this.upsertedId,
    this.upsertedCount,
    this.matchedCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    acknowledged: json["acknowledged"],
    modifiedCount: json["modifiedCount"],
    upsertedId: json["upsertedId"],
    upsertedCount: json["upsertedCount"],
    matchedCount: json["matchedCount"],
  );

  Map<String, dynamic> toJson() => {
    "acknowledged": acknowledged,
    "modifiedCount": modifiedCount,
    "upsertedId": upsertedId,
    "upsertedCount": upsertedCount,
    "matchedCount": matchedCount,
  };
}