class Witness {
  String name;
  String phone;

  Witness({this.name, this.phone});

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};
}
