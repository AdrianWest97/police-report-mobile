class Missing {
  String fname;
  String lname;
  String image;
  String age;
  String gender;
  String attributes;
  String details;
  String date;

  //address
  String city;
  String parish;
  String street;

  Missing(
      {this.fname,
      this.lname,
      this.image,
      this.age,
      this.gender,
      this.attributes,
      this.details,
      this.city,
      this.street,
      this.date,
      this.parish});
  Map<String, dynamic> toJson() => {
        'fname': fname,
        'lname': lname,
        'image': image,
        'age': age,
        'gender': gender,
        'attributes': attributes,
        'details': details,
        'city': city,
        'street': street,
        'parish': parish,
        'date': date
      };

  factory Missing.fromJson(Map<String, dynamic> json) {
    return Missing(
        fname: json['fname'],
        lname: json['lname'],
        age: json['age'],
        gender: json['gender'],
        attributes: json['attributes'],
        image: json['image']['path'],
        date: json['created_at'],
        details: json['last_seen_details']);
  }
}
