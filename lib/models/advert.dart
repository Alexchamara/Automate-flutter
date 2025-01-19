import 'dart:convert';
import 'dart:io';

import 'listing.dart';

class Advert {
  final int id;
  final String brand;
  final String model;
  final String year;
  final int mileage;
  final String condition;
  final String engine;
  final String color;
  final String bodyType;
  final String gearBox;
  final String fuelType;
  final double price;
  final String description;
  final String phone;
  final String email;
  final String location;
  final List<String> images;
  final Listing? listing;

  Advert({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.mileage,
    required this.condition,
    required this.engine,
    required this.color,
    required this.bodyType,
    required this.gearBox,
    required this.fuelType,
    required this.price,
    required this.description,
    required this.phone,
    required this.email,
    required this.location,
    required this.images,
    this.listing,
  });

  // Convert JSON object to advert object
  factory Advert.fromJson(Map<String, dynamic> json) {
    return Advert(
      id: json['id'] ?? 0,
      brand: json['make'] ?? '',
      model: json['model'] ?? '',
      year: json['registrationYear'] ?? '',
      mileage: json['mileage'] ?? 0,
      condition: json['condition'] ?? '',
      engine: json['engine'] ?? '',
      color: json['color'] ?? '',
      bodyType: json['bodyType'] ?? '',
      gearBox: json['transmission'] ?? '',
      fuelType: json['fuelType'] ?? '',
      price: json['price'] != null ? double.parse(json['price']) : 0.0,
      description: json['description'] ?? '',
      phone: json['contactNumber'] ?? '',
      email: json['advertEmail'] ?? '',
      location: json['location'] ?? '',
      // images: (json['advert']?['images'] != null)
      //     ? (jsonDecode(json['advert']?['images']) as List<dynamic>)
      //         .map((image) => image.toString())
      //         .toList()
      //     : [],
      images: json['images'] != null
          ? (jsonDecode(json['images']) as List<dynamic>)
              .map((image) => image.toString())
              .toList()
          : [],
      listing:
          json['listing'] != null ? Listing.fromJson(json['listing']) : null,
    );
  }

  // Convert advert object to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'images': jsonEncode(images?.map((filePath) {
        final file = File(filePath);
        final bytes = file.readAsBytesSync();
        final base64Str = base64Encode(bytes);
        return 'data:image/${file.path.split('.').last};base64,$base64Str';
      }).toList()),
      'listing': listing?.toJson(),
    };
  }
}
