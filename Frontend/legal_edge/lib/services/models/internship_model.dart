import 'package:flutter/foundation.dart';

class Internship {
  String? id;
  String? heading;
  String? name;
  String? email;
  String? time;
  String? desc;
  String? responsibility;
  String? qualifications;
  String? offers;
  List<String?>? applicants;
  Internship({
    this.id,
    this.heading,
    this.name,
    this.email,
    this.time,
    this.desc,
    this.responsibility,
    this.qualifications,
    this.offers,
    this.applicants,
  });

  Internship copyWith({
    String? id,
    String? heading,
    String? name,
    String? email,
    String? time,
    String? desc,
    String? responsibility,
    String? qualifications,
    String? offers,
    List<String?>? applicants,
  }) {
    return Internship(
      id: id ?? this.id,
      heading: heading ?? this.heading,
      name: name ?? this.name,
      email: email ?? this.email,
      time: time ?? this.time,
      desc: desc ?? this.desc,
      responsibility: responsibility ?? this.responsibility,
      qualifications: qualifications ?? this.qualifications,
      offers: offers ?? this.offers,
      applicants: applicants ?? this.applicants,
    );
  }

  List<String?>? fromDynamic(List<dynamic> list) {
    List<String> temp = [];
    for (var v in list) {
      temp.add(v.toString());
    }
    return temp;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    String? fname = '';
    String? lname = '';
    if (name != null) {
      List<String>? n = name?.split(' ');
      fname = n?[0];
      lname = n?[1];
    }
    data['lawyerId']['firstName'] = fname;
    data['lawyerId']['lastName'] = lname;
    data['lawyerId']['email'] = email;
    data['heading'] = heading;
    data['responsibility'] = responsibility;
    data['qualifications'] = qualifications;
    data['offers'] = offers;
    data['desc'] = desc;
    data['applicants'] = applicants;
    data['createdAt'] = time;
    return data;
  }

  Internship.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['lawyerId']['firstName'] + " " + json['lawyerId']['lastName'];
    email = json['lawyerId']['email'];
    responsibility = json['responsibility'];
    qualifications = json['qualifications'];
    offers = json['offers'];
    heading = json['heading'];
    desc = json['desc'];
    time = json['createdAt'];
    applicants = fromDynamic(json['applicants']);
  }

  static List<Internship> oppsFromSnapshot(List posts) {
    return posts.map((data) {
      return Internship.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Internship(id: $id, heading: $heading, name: $name, email: $email, time: $time, desc: $desc, responsibility: $responsibility, qualifications: $qualifications, offers: $offers, applicants: $applicants)';
  }

  @override
  bool operator ==(covariant Internship other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.heading == heading &&
        other.name == name &&
        other.email == email &&
        other.time == time &&
        other.desc == desc &&
        other.responsibility == responsibility &&
        other.qualifications == qualifications &&
        other.offers == offers &&
        listEquals(other.applicants, applicants);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        heading.hashCode ^
        name.hashCode ^
        email.hashCode ^
        time.hashCode ^
        desc.hashCode ^
        responsibility.hashCode ^
        qualifications.hashCode ^
        offers.hashCode ^
        applicants.hashCode;
  }
}
// / {
//       "_id": "65049b8ef24aedd1f52969a4",
//       "lawyerId": {
//         "_id": "6501f9b099eb9bd2b3265167",
//         "firstName": "Akash",
//         "lastName": "Sharma",
//         "email": "lawyer1@gmail.com"
//       },
//       "heading": "gdfgdgdgddd",
//       "desc": "fsadfsdf",
//       "responsibility": "sdfsadfdsf",
//       "qualifications": "fsdfasfds",
//       "offers": "fsadfsdafs",
//       "applicants": [],
//       "createdAt": "2023-09-15T17:59:42.370Z",
//       "__v": 0
//     }