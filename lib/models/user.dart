class User {
  String email;
  String name;
  int id;
  String phoneno;
  String trn;
  String gender;

  //address
  String parish;
  String city;
  String street;

  User(
      {this.email,
      this.name,
      this.phoneno,
      this.trn,
      this.gender,
      this.id,
      this.city,
      this.parish,
      this.street});

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'email': email,
        'phoneno': phoneno,
        'gender': gender,
        'trn': trn,
        'city': city,
        'parish': parish,
        'street': street
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneno: json['phoneno'],
      trn: json['trn'],
      gender: json['gender'],
      parish: json['address'] == null ? null : json['address']['parish'],
      city: json['address'] == null ? null : json['address']['city'],
      street: json['street'] == null ? null : json['address']['street'],
    );
  }
}
