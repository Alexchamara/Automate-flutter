import 'dart:io';

class Listing {
  final String description;
  final double price;
  final String token;
  final String phone;
  final int userId;
  final String email;
  final String location;
  final int mileage;
  final String brand;
  final String model;
  final String year;
  final String condition;
  final String engine;
  final String color;
  final String bodyType;
  final String gearBox;
  final String fuelType;
  final List<File>? images;

  Listing({
    required this.description,
    required this.price,
    required this.token,
    required this.phone,
    required this.userId,
    required this.email,
    required this.location,
    required this.mileage,
    required this.brand,
    required this.model,
    required this.year,
    required this.condition,
    required this.engine,
    required this.color,
    required this.bodyType,
    required this.gearBox,
    required this.fuelType,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'make': brand,
      'model': model,
      'registrationYear': year,
      'mileage': mileage,
      'condition': condition,
      'engine': engine,
      'color': color,
      'bodyType': bodyType,
      'transmission': gearBox,
      'fuelType': fuelType,
      'price': price,
      'description': description,
      'contactNumber': phone,
      'advertEmail': email,
      'location': location,
      'images': images,
    };
  }
}