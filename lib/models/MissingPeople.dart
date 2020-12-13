class Missing {
  String name;
  String image;
  String age;
  String gender;
  String attributes;
  String details;
  String date;
  String lastSeenDate;
  String headline;

  //address
  String city;
  String parish;
  String street;

  Missing(
      {this.name,
      this.image,
      this.age,
      this.gender,
      this.attributes,
      this.details,
      this.city,
      this.street,
      this.date,
      this.parish,
      this.lastSeenDate,
      this.headline});
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'age': age,
        'gender': gender,
        'attributes': attributes,
        'details': details,
        'city': city,
        'street': street,
        'parish': parish,
        'date': date,
        'lastSeenDate': lastSeenDate,
        'headline': headline
      };

  factory Missing.fromJson(Map<String, dynamic> json) {
    return Missing(
        name: json['name'],
        age: json['age'],
        gender: json['gender'],
        attributes: json['attributes'],
        image: json['image']['path'],
        date: json['created_at'],
        lastSeenDate: json['last_seen_date'],
        headline: json['headline'],
        details: json['last_seen_details']);
  }
}
