import 'dart:convert';

import 'Witness.dart';

class Report {
  String details;
  String additional;
  String type;
  String date;
  int status;
  int hasWitness;
  String reference_number;
  int id;
  String witnesses;

  //address
  String city;
  String parish;
  String street;

  Report(
      {this.details,
      this.additional,
      this.id,
      this.type,
      this.date,
      this.status,
      this.hasWitness,
      this.reference_number,
      this.city,
      this.parish,
      this.street,
      this.witnesses});

  Map<String, dynamic> toJson() => {
        'details': details,
        'additional': additional,
        'type': type,
        'date': date,
        'status': status,
        'hasWitness': hasWitness,
        'reference_number': reference_number,
        'city': city,
        'parish': parish,
        'street': street,
        'witnesses': witnesses,
        'id': id
      };

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        details: json['details'],
        additional: json['additional'],
        type: json['type']['type'],
        date: json['date'],
        status: json['status'],
        hasWitness: json['hasWitness'],
        reference_number: json['reference_number'],
        city: json['address']['city'],
        street: json['address']['street'],
        parish: json['address']['parish'],
        witnesses: jsonEncode(json['witnesses']),
        id: json['id']);
  }
}
