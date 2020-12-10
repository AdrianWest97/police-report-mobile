class Witness {
  String name;
  String phone;

  Witness({this.name, this.phone});

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};

  factory Witness.fromJson(Map<String, dynamic> json) {
    return Witness(
        name: json['witnesses']['name'], phone: json['witnesses']['phone']);
  }
}
