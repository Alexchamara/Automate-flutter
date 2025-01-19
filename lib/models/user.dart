import 'listing.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String token;
  final String role;
  final List<Listing> listings;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token = '',
    this.role = '',
    this.listings = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      role: json['role'] ?? '',
      listings: (json['listings'] as List<dynamic>?)
          ?.map((listing) => Listing.fromJson(listing))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'role': role,
      'listings': listings.map((listing) => listing.toJson()).toList(),
    };
  }
}

// class User {
//   final int id;
//   final String name;
//   final String email;
//   final String mobile;
//   final String role;
//   final bool isActive;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobile,
//     required this.role,
//     required this.isActive,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       mobile: json['mobile'],
//       role: json['role'],
//       isActive: json['isActive'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'mobile': mobile,
//       'role': role,
//       'isActive': isActive,
//     };
//   }
// }