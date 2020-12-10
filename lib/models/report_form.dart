import 'package:prms/models/Witness.dart';

class ReportForm {
  String date;
  String type;
  String parish;
  String city;
  String street;
  String details;
  String additional;
  bool hasWitness;
  String witnesses;
  bool accepted_terms;

  ReportForm(
      {this.date,
      this.type,
      this.parish,
      this.city,
      this.street,
      this.details,
      this.additional,
      this.hasWitness,
      this.witnesses,
      this.accepted_terms});

  Map<String, dynamic> toJson() => {
        'date': date,
        'type': type,
        'parish': parish,
        'city': city,
        'street': street,
        'details': details,
        'additional': additional,
        'witnesses': witnesses,
        'hasWitness': hasWitness,
        'accepted_terms': accepted_terms
      };
}
