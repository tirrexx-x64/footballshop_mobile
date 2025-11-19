// To parse this JSON data, do
//
//     final products = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String model;
  String pk;
  Fields fields;

  Product({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String name;
  int price;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  int stock;
  String brand;
  DateTime createdAt;

  Fields({
    required this.user,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.stock,
    required this.brand,
    required this.createdAt,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"] != null ? (json["user"] is int ? json["user"] : int.tryParse(json["user"].toString()) ?? 0) : 0,
        name: json["name"] ?? "",
        price: json["price"] != null ? (json["price"] is int ? json["price"] : int.tryParse(json["price"].toString()) ?? 0) : 0,
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        category: json["category"] ?? "",
        isFeatured: json["is_featured"] ?? false,
        stock: json["stock"] != null ? (json["stock"] is int ? json["stock"] : int.tryParse(json["stock"].toString()) ?? 0) : 0,
        brand: json["brand"] ?? "",
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "brand": brand,
        "created_at": createdAt.toIso8601String(),
      };
}
