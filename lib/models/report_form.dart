import 'package:prms/models/Witness.dart';

class ReportForm {
  DateTime date;
  String type;
  String parish;
  String city;
  String street;
  String details;
  bool hasWitness;
  List<Witness> witnesses;
  bool accepted_terms;

  ReportForm(
      {this.date,
      this.type,
      this.parish,
      this.city,
      this.street,
      this.details,
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
        'witnesses': witnesses,
        'hasWitness': hasWitness,
        'accepted_terms': accepted_terms
      };
}
