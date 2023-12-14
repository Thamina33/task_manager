// To parse this JSON data, do
//
//     final emailVerificationResp = emailVerificationRespFromJson(jsonString);

import 'dart:convert';

EmailVerificationResp emailVerificationRespFromJson(String str) => EmailVerificationResp.fromJson(json.decode(str));

String emailVerificationRespToJson(EmailVerificationResp data) => json.encode(data.toJson());

class EmailVerificationResp {
  String? status;
  Data? data;

  EmailVerificationResp({
    this.status,
    this.data,
  });

  factory EmailVerificationResp.fromJson(Map<String, dynamic> json) => EmailVerificationResp(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  List<String>? accepted;
  List<dynamic>? rejected;
  List<String>? ehlo;
  int? envelopeTime;
  int? messageTime;
  int? messageSize;
  String? response;
  Envelope? envelope;
  String? messageId;

  Data({
    this.accepted,
    this.rejected,
    this.ehlo,
    this.envelopeTime,
    this.messageTime,
    this.messageSize,
    this.response,
    this.envelope,
    this.messageId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accepted: json["accepted"] == null ? [] : List<String>.from(json["accepted"]!.map((x) => x)),
    rejected: json["rejected"] == null ? [] : List<dynamic>.from(json["rejected"]!.map((x) => x)),
    ehlo: json["ehlo"] == null ? [] : List<String>.from(json["ehlo"]!.map((x) => x)),
    envelopeTime: json["envelopeTime"],
    messageTime: json["messageTime"],
    messageSize: json["messageSize"],
    response: json["response"],
    envelope: json["envelope"] == null ? null : Envelope.fromJson(json["envelope"]),
    messageId: json["messageId"],
  );

  Map<String, dynamic> toJson() => {
    "accepted": accepted == null ? [] : List<dynamic>.from(accepted!.map((x) => x)),
    "rejected": rejected == null ? [] : List<dynamic>.from(rejected!.map((x) => x)),
    "ehlo": ehlo == null ? [] : List<dynamic>.from(ehlo!.map((x) => x)),
    "envelopeTime": envelopeTime,
    "messageTime": messageTime,
    "messageSize": messageSize,
    "response": response,
    "envelope": envelope?.toJson(),
    "messageId": messageId,
  };
}

class Envelope {
  String? from;
  List<String>? to;

  Envelope({
    this.from,
    this.to,
  });

  factory Envelope.fromJson(Map<String, dynamic> json) => Envelope(
    from: json["from"],
    to: json["to"] == null ? [] : List<String>.from(json["to"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to == null ? [] : List<dynamic>.from(to!.map((x) => x)),
  };
}
