import 'dart:convert';
import 'dart:io';

class Listing {
  final int id;
  final int userId;
  final int advertId;
  final String status;
  final DateTime statusUpdatedAt;
  final bool isActive;
  final String paymentStatus;
  final DateTime? paymentStatusUpdatedAt;
  final DateTime? expirationDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String token;
  final String brand; //
  final String model; //
  final String year; //
  final int mileage; //
  final String condition; //
  final String color; //
  final String engine; //
  final String bodyType; //
  final String gearBox; //
  final String fuelType; //
  final double price; //
  final String description; //
  final String phone;
  final String email;
  final String location;
  final List<File>? images;

  Listing({
    required this.id,
    required this.userId,
    required this.advertId,
    required this.status,
    required this.statusUpdatedAt,
    required this.isActive,
    required this.paymentStatus,
    this.paymentStatusUpdatedAt,
    this.expirationDate,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
    required this.brand,
    required this.model,
    required this.year,
    required this.mileage,
    required this.condition,
    required this.color,
    required this.engine,
    required this.bodyType,
    required this.gearBox,
    required this.fuelType,
    required this.price,
    required this.description,
    required this.phone,
    required this.email,
    required this.location,
    this.images,
  });

  // Convert Listing object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'advert_id': advertId,
      'status': status,
      'status_updated_at': statusUpdatedAt.toIso8601String(),
      'isActive': isActive,
      'payment_status': paymentStatus,
      'payment_status_updated_at': paymentStatusUpdatedAt?.toIso8601String(),
      'expiration_date': expirationDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'token': token,
      'make': brand,
      'model': model,
      'registrationYear': year,
      'mileage': mileage,
      'condition': condition,
      'color': color,
      'engine': engine,
      'bodyType': bodyType,
      'transmission': gearBox,
      'fuelType': fuelType,
      'price': price,
      'description': description,
      'contactNumber': phone,
      'advertEmail': email,
      'location': location,
      'images': jsonEncode(images?.map((file) {
        final bytes = file.readAsBytesSync();
        final base64Str = base64Encode(bytes);
        return 'data:image/${file.path.split('.').last};base64,$base64Str';
      }).toList()),
    };
  }

  // Convert JSON object to Listing object
  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      advertId: json['advert_id'] ?? 0,
      status: json['status'] ?? '',
      statusUpdatedAt: json['status_updated_at'] != null
          ? DateTime.parse(json['status_updated_at'])
          : DateTime.now(),
      isActive: json['isActive'] ?? false,
      paymentStatus: json['payment_status'] ?? '',
      paymentStatusUpdatedAt: json['payment_status_updated_at'] != null
          ? DateTime.parse(json['payment_status_updated_at'])
          : null,
      expirationDate: json['expiration_date'] != null
          ? DateTime.parse(json['expiration_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      token: json['token'] ?? '',
      brand: json['make'],
      model: json['model'],
      year: json['registrationYear'],
      mileage: json['mileage'],
      condition: json['condition'],
      color: json['color'],
      engine: json['engine'],
      bodyType: json['bodyType'],
      gearBox: json['transmission'],
      fuelType: json['fuelType'],
      price: json['price'] != null ? double.parse(json['price']) : 0.0,
      description: json['description'],
      phone: json['contactNumber'],
      email: json['advertEmail'],
      location: json['location'],
      images: (json['advert']?['images'] != null)
          ? (jsonDecode(json['advert']?['images']) as List<dynamic>)
              .map((image) => File(image))
              .toList()
          : [],
    );
  }
}

// class Listing {
//   final int userId;
//   final String token;
//   final String brand;
//   final String model;
//   final String year;
//   final int mileage;
//   final String condition;
//   final String color;
//   final String engine;
//   final String bodyType;
//   final String gearBox;
//   final String fuelType;
//   final double price;
//   final String description;
//   final String phone;
//   final String email;
//   final String location;
//   final List<File>? images;
//
//   Listing({
//     required this.userId,
//     required this.token,
//     required this.brand,
//     required this.model,
//     required this.year,
//     required this.mileage,
//     required this.condition,
//     required this.color,
//     required this.engine,
//     required this.bodyType,
//     required this.gearBox,
//     required this.fuelType,
//     required this.price,
//     required this.description,
//     required this.phone,
//     required this.email,
//     required this.location,
//     this.images,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'user_id': userId,
//       'make': brand,
//       'model': model,
//       'registrationYear': year,
//       'mileage': mileage,
//       'condition': condition,
//       'engine': engine,
//       'color': color,
//       'bodyType': bodyType,
//       'transmission': gearBox,
//       'fuelType': fuelType,
//       'price': price,
//       'description': description,
//       'contactNumber': phone,
//       'advertEmail': email,
//       'location': location,
//       'images': images?.map((file) {
//         final bytes = file.readAsBytesSync();
//         final base64Str = base64Encode(bytes);
//         return 'data:image/${file.path.split('.').last};base64,$base64Str';
//       }).toList(),
//     };
//   }
//
//   factory Listing.fromJson(Map<String, dynamic> json) {
//     return Listing(
//       userId: json['user_id'],
//       token: json['token'],
//       brand: json['make'],
//       model: json['model'],
//       year: json['registrationYear'],
//       mileage: json['mileage'],
//       condition: json['condition'],
//       color: json['color'],
//       engine: json['engine'],
//       bodyType: json['bodyType'],
//       gearBox: json['transmission'],
//       fuelType: json['fuelType'],
//       price: json['price'],
//       description: json['description'],
//       phone: json['contactNumber'],
//       email: json['advertEmail'],
//       location: json['location'],
//       images: (json['images'] as List<dynamic>?)
//           ?.map((image) => File(image))
//           .toList(),
//     );
//   }
// }
