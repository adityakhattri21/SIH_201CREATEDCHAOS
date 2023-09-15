// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  String? name;
  String? email;
  String? id;
  String? title;
  String? description;
  String? time;
  String? profileP;
  int? likes;
  List<String?>? likedBy;
  Post({
    required this.name,
    required this.email,
    required this.title,
    required this.description,
    required this.profileP,
    required this.likes,
    this.likedBy,
    this.id,
  });
  Post copyWith({
    String? email,
    String? title,
    String? description,
  }) {
    return Post(
      name: name ?? this.name,
      email: email ?? this.name,
      title: title ?? this.title,
      description: description ?? this.description,
      profileP: profileP ?? this.profileP,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'title': title,
      'desc': description,
      'url': profileP,
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'],
      name: map['user']['name'] as String,
      email: map['user']['email'] as String,
      title: map['title'] as String,
      description: map['desc'] as String,
      profileP: map['user']['url'] as String,
      likes: map['likes']['noOFLikes'] as int,
    );
  }

  List<String?>? fromDynamic(List<dynamic> list) {
    List<String> temp = [];
    for (var v in list) {
      temp.add(v.toString());
    }
    return temp;
  }

  Post.fromjson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['user']['name'];
    email = json['user']['email'];
    profileP = json['user']['url'];
    title = json['title'];
    description = json['desc'];
    time = json['createdAt'];
    likes = json['likes']['noOFLikes'];
    likedBy = fromDynamic(json['likes']['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user']['name'] = name;
    data['user']['email'] = email;
    data['user']['url'] = profileP;
    data['title'] = title;
    data['desc'] = description;
    return data;
  }

  static List<Post> postFromSnapshot(List posts) {
    return posts.map((data) {
      return Post.fromjson(data);
    }).toList();
  }

  @override
  String toString() =>
      'Post(name: $name, title: $title, description: $description, createdAt: $time)';

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.title == title &&
        other.description == description &&
        other.time == time;
  }

  @override
  int get hashCode =>
      name.hashCode ^ title.hashCode ^ description.hashCode ^ time.hashCode;
}

// import 'dart:convert';

// import 'package:legal_edge/services/models/user_model.dart';

// class Post {
//   User? user;
//   String? title;
//   String? description;
//   String? time;
//   Post({
//     required this.user,
//     required this.title,
//     required this.description,
//   });
//   Post copyWith({
//     User? user,
//     String? title,
//     String? description,
//   }) {
//     return Post(
//       user: user,
//       title: title ?? this.title,
//       description: description ?? this.description,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'user': user,
//       'title': title,
//       'desc': description,
//     };
//   }

//   factory Post.fromMap(Map<String, dynamic> map) {
//     return Post(
//       user: User.fromMap(map['user']),
//       title: map['title'] as String,
//       description: map['desc'] as String,
//     );
//   }

//   Post.fromjson(Map<String, dynamic> json) {
//     user = User.fromMap(json['user']);
//     print('user : ${json['user']}');
//     title = json['title'];
//     description = json['desc'];
//     time = json['time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user'] = jsonEncode(user);
//     data['title'] = title;
//     data['desc'] = description;
//     return data;
//   }

//   static List<Post> postFromSnapshot(List posts) {
//     return posts.map((data) {
//       return Post.fromjson(data);
//     }).toList();
//   }

//   @override
//   String toString() =>
//       'Post(user: $user, title: $title, description: $description, time: $time)';

//   @override
//   bool operator ==(covariant Post other) {
//     if (identical(this, other)) return true;

//     return other.user == user &&
//         other.title == title &&
//         other.description == description &&
//         other.time == time;
//   }

//   @override
//   int get hashCode =>
//       user.hashCode ^ title.hashCode ^ description.hashCode ^ time.hashCode;
// }
// NEW FORMAT OF JSON
// {
//       "_id": "650351e3c771e8ea71a2c719",
//       "userId": {
//         "_id": "65029e16187e155103740db4",
//         "firstName": "Akash",
//         "lastName": "Sharma",
//         "email": "akashsharma2002@gmail.com",
//         "gender": "Male",
//         "contact": 7388898610,
//         "city": "Lucknow",
//         "state": "Uttar Pradesh",
//         "postalCode": "260014",
//         "aadharNumber": "123456789012",
//         "__v": 0
//       },
//       "heading": "Naruto>>> One Peice",
//       "tags": [],
//       "desc": "hhuuuiiihuihuihuiihuihiu....",
//       "time": "2023-09-15 00:03:05.901424",
//       "comments": [],
//       "__v": 0,
//       "url": "https://st3.depositphotos.com/1017228/18878/i/450/depositphotos_188781580-stock-photo-handsome-cheerful-young-man-standing.jpg"
//     }

class NewPost {
  String? id;
  String? title;
  String? desc;
  String? time;
  String? photoUrl;
  String? name;
  String? email;
  List<String?>? tags;
  List<String?>? comments;
  NewPost({
    this.id,
    this.title,
    this.desc,
    this.time,
    this.photoUrl,
    this.name,
    this.email,
    this.tags,
    this.comments,
  });

  NewPost copyWith({
    String? id,
    String? title,
    String? desc,
    String? time,
    String? photoUrl,
    String? name,
    String? email,
    List<String?>? tags,
    List<String?>? comments,
  }) {
    return NewPost(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      time: time ?? this.time,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      tags: tags ?? this.tags,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desc': desc,
      'time': time,
      'photoUrl': photoUrl,
      'name': name,
      'email': email,
      // 'tags': tags.map((x) => x?.toMap()).toList(),
      // 'comments': comments.map((x) => x?.toMap()).toList(),
    };
  }

  factory NewPost.fromMap(Map<String, dynamic> map) {
    return NewPost(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      // tags: map['tags'] != null ? List<String?>.from((map['tags'] as List<int>).map<String??>((x) => String?.fromMap(x as Map<String,dynamic>),),) : null,
      // comments: map['comments'] != null ? List<String?>.from((map['comments'] as List<int>).map<String??>((x) => String?.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  List<String?>? fromDynamic(List<dynamic> list) {
    List<String> temp = [];
    for (var v in list) {
      temp.add(v.toString());
    }
    return temp;
  }

  NewPost.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['userId']['firstName'] + " " + json['userId']['lastName'];
    email = json['userId']['email'];
    photoUrl = json['url'];
    title = json['heading'];
    desc = json['desc'];
    time = json['time'];
    comments = fromDynamic(json['comments']);
    tags = fromDynamic(json['tags']);
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
    data['userId']['firstName'] = fname;
    data['userId']['lastName'] = lname;
    data['userId']['email'] = email;
    data['url'] =
        photoUrl; //TODO yaha shayad error aa sakta hai... photourl must bein users data
    data['heading'] = title;
    data['desc'] = desc;
    data['comments'] = comments;
    data['tags'] = tags;
    return data;
  }

  static List<NewPost> postFromSnapshot(List posts) {
    return posts.map((data) {
      return NewPost.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'NewPost(id: $id, title: $title, desc: $desc, time: $time, photoUrl: $photoUrl, name: $name, email: $email, tags: $tags, comments: $comments)';
  }

  @override
  bool operator ==(covariant NewPost other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.time == time &&
        other.photoUrl == photoUrl &&
        other.name == name &&
        other.email == email &&
        listEquals(other.tags, tags) &&
        listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        time.hashCode ^
        photoUrl.hashCode ^
        name.hashCode ^
        email.hashCode ^
        tags.hashCode ^
        comments.hashCode;
  }
}
